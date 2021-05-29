source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.3'
gem 'lograge'
gem 'rollbar'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'redis'
gem 'rss'
gem 'sidekiq'
gem 'simpacker'
gem 'okcomputer'
gem "skylight"

group :development, :test do
  gem 'brakeman', require: false
  gem 'rspec-rails', require: false
  gem 'factory_bot_rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem "rubycritic", require: false
  gem 'dotenv-rails'
  gem 'spp'
end

group :development do
  gem 'listen', '~> 3.5'
  gem 'annotate'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end
