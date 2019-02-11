class Api::FeedsController < ApplicationController
  def index
    @feeds = Feed.all.includes(:last_entry).order('entries.published_at DESC')
    @last_entries = @feeds.map(&:last_entry)
    object = { feeds: @feeds, last_entries: @last_entries }
    render json: object
  end
end
