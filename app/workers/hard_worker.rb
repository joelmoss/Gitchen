class HardWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(id)
    user = User.find(id)
    user.fetch_watched_repos unless user.fetching_repos?
  end
end