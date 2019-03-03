class Api::FeedsController < ApplicationController
  PER_PAGE = 6

  def index
    @feeds = Feed.recent.pager(page: params[:page], per: PER_PAGE)
    @last_entries = @feeds.includes(:last_entry).map(&:last_entry)
    object = { feeds: @feeds, last_entries: @last_entries }
    render json: object
  end
end
