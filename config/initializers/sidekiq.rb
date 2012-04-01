Sidekiq.configure_server do |config|
  config.redis = { :namespace => "gitchen_#{Rails.env[0...3]}", :size => 25 }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => "gitchen_#{Rails.env[0...3]}", :size => 1 }
end