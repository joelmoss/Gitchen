Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Gitchen::Config.github_key, Gitchen::Config.github_secret, :scope => "user,repo"
end