if Rails.env.production?
  Gitchen::Config.configure do
    github_key ENV['GITHUB_KEY']
    github_secret ENV['GITHUB_SECRET']
  end
else
  Gitchen::Config.configure :from_file => Rails.root.join('config', 'gitchen.yml')
end