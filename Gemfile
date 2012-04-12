source 'https://rubygems.org'

gem 'rails', '~> 3.2'
gem 'mysql2'
gem 'oj'
gem 'omniauth-github'
gem 'hashie'
gem 'octokit'
gem 'kaminari', git: "https://github.com/joelmoss/kaminari", branch: "current_page_count"
gem 'tire'
gem 'sidekiq'
gem 'slim'
gem 'sinatra'
gem 'coffeebeans'
gem 'exceptional'
gem 'scoped_search'
gem 'attribute_normalizer'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'inherited_resources'

group :production do
  gem 'pg'
  gem 'foreman'
  gem 'thin'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'rb-fsevent'
  gem 'growl'
  gem 'debugger'
end

group :test do
  gem 'sqlite3'
  gem 'webmock'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'marked'
end