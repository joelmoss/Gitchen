class FetchWorker
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)
    user.fetch_watched_repos unless user.fetching_repos?
  rescue ActiveRecord::RecordNotFound => e
    Sidekiq::Util.logger.debug { e.message }
  end
end