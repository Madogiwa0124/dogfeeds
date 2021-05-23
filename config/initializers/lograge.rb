# frozen_string_literal: true

require Rails.root.join('lib/lograge/formatters/marked_key_value')

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::MarkedKeyValue.new
  config.lograge.custom_options = ->(event) { { time: Time.current } }
end
