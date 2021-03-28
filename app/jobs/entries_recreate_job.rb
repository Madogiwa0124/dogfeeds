# frozen_string_literal: true

class EntriesRecreateJob < ApplicationJob
  sidekiq_options retry: false

  def perform(feed)
    ActiveRecord::Base.transaction { Feed::EntryCreater.new(feed).execute! }
  rescue StandardError => error
    raised_error = e.exception("#{error.message} raised from endpoint: #{feed.endpoint}")
    Rails.logger.error(raised_error)
    Rollbar.error(raised_error)
  end
end
