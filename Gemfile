source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'rollbar'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'rss'
gem 'simpacker'

group :development, :test do
  gem 'brakeman'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'dotenv-rails'
  gem 'spp'
  gem 'bullet'
end

group :development do
  gem 'listen', '~> 3.4'
  gem 'annotate'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end
