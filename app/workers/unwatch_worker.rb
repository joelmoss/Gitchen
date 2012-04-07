class UnwatchWorker
  include Sidekiq::Worker

  def perform(id)
    watch = Watch.unscoped.find(id)
    watch.watcher.github.unwatch "#{watch.watching.owner}/#{watch.watching}" if Rails.env.production?
    watch.destroy
  rescue ActiveRecord::RecordNotFound => e
    Sidekiq::Util.logger.debug { e.message }
  end
end