require 'spec_helper'
require 'helpers/rss_mock_helper'
require 'helpers/authentication_helper'

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include AuthenticationHelper, :type => :system
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.before(:each, type: :system) do |example|
    example.metadata[:js] ? driven_by(:headless_chrome) : driven_by(:rack_test)
  end
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end
end
