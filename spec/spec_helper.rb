require 'simplecov'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

SimpleCov.start do
  add_filter '/spec/'
  enable_coverage :branch
  add_filter do |source_file|
    source_file.lines.count < 5
  end

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
end
