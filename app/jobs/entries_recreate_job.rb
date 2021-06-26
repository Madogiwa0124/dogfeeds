# frozen_string_literal: true

class EntriesRecreateJob < ApplicationJob
  sidekiq_options retry: false

  def perform(feed)
    ActiveRecord::Base.transaction { Feed::EntryCreater.new(feed).execute! }
  rescue StandardError => error
    Rails.logger.error(error.exception("#{error.message} raised from endpoint: #{feed.endpoint}"))
    Rollbar.error(error, endpoint: endpoint)
  end
end
