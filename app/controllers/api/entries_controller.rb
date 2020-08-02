class Api::EntriesController < ApplicationController
  DISPLAY_LIMIT = 15

  def index
    entries = Entry.where(feed_id: request_feed_ids).recent.limit(DISPLAY_LIMIT)
    response = entries.map { |entry| ::Api::Entry.new(entry: entry).attributes }
    render json: response
  end

  private

  def request_feed_ids
    # NOTE: Feedのidは単数でも複数でも受け付けられるようにArray.wrapで配列に変換している
    Array.wrap(params.required(:feedId)).map(&:to_i)
  end
end
