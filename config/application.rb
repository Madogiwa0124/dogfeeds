require "active_support/core_ext/integer/time"
require_relative 'boot'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
# require 'action_cable/engine'
# require 'action_mailbox/engine'
# require 'action_text/engine'
# require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module Dogfeeds
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.default_locale = :ja
    config.i18n.fallbacks = [:en]
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.paths.add 'lib', eager_load: true
    config.generators do |g|
      g.assets      false
      g.helper      false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| %Q(#{html_tag}).html_safe }
    config.active_job.queue_adapter = :sidekiq
    config.action_mailer.deliver_later_queue_name = 'default'
    config.active_record.database_selector = { delay: 2.seconds }
    config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
    config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session

    # rails consoleではstrict loadingを無効化
    console { ApplicationRecord.strict_loading_by_default = false }
    # Rails engineで導入されているokcomputerのcontrollerのオーバーライド
    # https://edgeguides.rubyonrails.org/engines.html#overriding-models-and-controllers
    config.to_prepare do
      load "#{Rails.root}/lib/okcomputer/app/controllers/ok_computer_controller.rb"
    end
  end
end
