source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'sass-rails', '>= 6'
gem 'webpacker'

group :development, :test do
  gem 'brakeman'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'dotenv-rails'
  gem 'spp'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'annotate'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
end
