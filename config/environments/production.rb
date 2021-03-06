require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{365.days.to_i}"
  }
  config.log_level = :info
  config.log_tags = [ :request_id ]

  config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }
  config.session_store :cache_store
  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :notify
  config.active_support.disallowed_deprecation = :log
  config.active_support.disallowed_deprecation_warnings = []
  config.log_formatter = ::Logger::Formatter.new
  config.force_ssl = true

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  # NOTE: 本番環境では稼働優先でlogに出力するだけにしとく
  config.active_record.action_on_strict_loading_violation = :log
end
