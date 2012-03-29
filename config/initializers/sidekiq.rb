Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'gitchen', :size => 25 }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'gitchen', :size => 1 }
end