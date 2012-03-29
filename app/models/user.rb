class User < ActiveRecord::Base

  # The github data will be serialzed as a Hash.
  serialize :github_data

  # Delegate github attributes to #github_data.
  delegate :avatar_url, :html_url, :to => :github_data

  after_create proc {|user| HardWorker.perform_async user.id }


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

  def fetch_watched_repos
    github.watched
  end

end
