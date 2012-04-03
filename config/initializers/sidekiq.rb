# We don't use this in production and when run over Heroku. Remove the unless
# statement if you are not running Gtchen on Heroku.
unless Rails.env.production?

  Sidekiq.configure_server do |config|
    config.redis = { :namespace => "gitchen_#{Rails.env[0...3]}", :size => 25 }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :namespace => "gitchen_#{Rails.env[0...3]}", :size => 1 }
  end

end