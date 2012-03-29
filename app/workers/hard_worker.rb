class HardWorker
  include Sidekiq::Worker

  def perform(id)
    User.find(id).fetch_watched_repos
  end
end