class User < ActiveRecord::Base

  has_many :repos, :foreign_key => "user_id"
  has_many :watches do
    def unwatch(repo)
      where(repo_id: repo.id).first.unwatch
    end
  end
  has_many :watchings, :through => :watches, :class_name => "Repo", :uniq => true do
    def sample(query = {})
      if Rails.configuration.database_configuration[Rails.env]['adapter'] == 'postgresql'
        relation = order('RANDOM()').select('repos.*, RANDOM()').limit(query[:limit] || 4)
      else
        relation = order('RAND()').limit(query[:limit] || 4)
      end

      relation = relation.where(query[:where]) if query.key?(:where)
    end
  end

  # The github data will be serialzed as a Hash.
  serialize :github_data

  # Delegate github attributes to #github_data.
  delegate :avatar_url, :html_url, :to => :github_data


  def to_s
    username
  end

  # Convert the github data into a Hashie::Mash object, so that delegation works.
  #
  # Returns a Hashie::Mash object.
  def github_data
    @github_data ||= Hashie::Mash.new(read_attribute(:github_data))
  end

  # Returns an authenticated instance of Octokit.
  def github
    @github ||= begin
      if username.present? && github_access_token.present?
        Octokit::Client.new(login: username, oauth_token: github_access_token, auto_traversal: true)
      else
        nil
      end
    end
  end

  # Is this user authorized for full Github API access using an OAuth access
  # token?
  #
  # Returns a Boolean.
  def authorized_for_github?
    !github.nil?
  end

  # Fetch all watched repos for this user, and create a Repo record for each one,
  # along with a User record for the owner, and of course the association between
  # Repo and watcher.
  def fetch_watched_repos
    toggle! :fetching_repos

    sidekiq_logger.info { "[#{username}] Fetching watched repos..." }

    github_watched.each do |wr|
      attrs = wr.slice(:name, :language, :description, :fork, :private, :size,
                       :forks, :open_issues, :pushed_at, :created_at, :updated_at)

      if repo = Repo.find_by_id(wr.id)
        repo.attributes = attrs.merge({:watchers_count => wr.watchers})
      else
        repo = Repo.new(attrs.merge({:watchers_count => wr.watchers}))
        repo.id = wr.id
      end

      repo.owner = User.find_or_create_by_username(wr.owner.login)
      repo.save

      unless watchings.exists?(repo.id)
        watchings << repo
        sidekiq_logger.info { "[#{username}] now watching #{wr.name}" }
      end
    end

    sidekiq_logger.info { "[#{username}] Completed fetching watched repos" }

    prune_unwatched_repos

    toggle! :fetching_repos
  end

  # Prune repos that are no longer being watched.
  def prune_unwatched_repos
    gitchen_ids, github_ids = watchings.map(&:id), github_watched.map(&:id)

    sidekiq_logger.info { "[#{username}] Pruning watched repos..." }

    (pruned = watchings.find(gitchen_ids - github_ids)).each do |repo|
      sidekiq_logger.info { "[#{username}] stopped watching #{repo}" }
    end

    watchings.delete pruned

    sidekiq_logger.info { "[#{username}] Completed pruning watched repos" }
  end

  def github_watched
    @github_watched ||= github.watched
  end

  def sidekiq_logger
    Sidekiq::Util.logger
  end

end
