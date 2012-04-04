class User < ActiveRecord::Base

  has_many :watches
  has_many :watchings, :through => :watches, :class_name => "Repo", :uniq => true do
    def sample(query = {})
      if Rails.configuration.database_configuration[Rails.env]['adapter'] == 'postgres'
        random_function = 'RANDOM()'
      else
        random_function = 'RAND()'
      end

      relation = order('RAND()').limit(query[:limit] || 4)
      relation = relation.where(query[:where]) if query.key?(:where)
    end
  end
  has_many :repos, :foreign_key => "user_id"

  # The github data will be serialzed as a Hash.
  serialize :github_data

  # Delegate github attributes to #github_data.
  delegate :avatar_url, :html_url, :to => :github_data


  def to_s
    username
  end

  # Override that fetches watched repos after completion.
  def self.find_or_create_by_username(username, *attrs)
    if me = super
      HardWorker.perform_async(me.id) if me.github_access_token
    end
    me
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

    github.watched.each do |wr|
      attrs = wr.slice(:name, :language, :description, :fork, :private, :size, :forks,
                              :open_issues, :pushed_at, :created_at, :updated_at)
      repo = Repo.find_or_initialize_by_id(wr.id, attrs.merge({:watchers_count => wr.watchers}))
      repo.owner = User.find_or_create_by_username(wr.owner.login)
      repo.save
      watchings << repo
    end

    toggle! :fetching_repos
  end

end
