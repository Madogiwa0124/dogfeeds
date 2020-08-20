class Api::FeedsController < ApplicationController
  PER_PAGE = 12

  def index
    @feeds = Feed.preload(:last_entry, :tags)
                 .search(params.dig(:query, :keyword)).recent
                 .pager(page: params[:page], per: PER_PAGE)
    response = @feeds.map { |feed| ::Api::Feed.new(feed: feed).attributes }
    render json: response
  end

  def show
    feed = ::Api::Feed.new(feed: Feed.preload(:tags, :last_entry).find(params[:id]))
    render json: feed.attributes
  end
end
