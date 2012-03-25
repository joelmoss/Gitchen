class User < ActiveRecord::Base
  
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
  
  # Returns an authenticated instance of Github.
  def github
    Github.new(github_access_token) if github_access_token.present?
  end

  # Is this user authorized for full Github API access using an OAuth access
  # token?
  #
  # Returns a Boolean.
  def authorized_for_github?
    !github.nil?
  end
  
end
