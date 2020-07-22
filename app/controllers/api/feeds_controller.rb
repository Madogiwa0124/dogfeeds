class Api::FeedsController < ApplicationController
  PER_PAGE = 6

  def index
    @feeds = Feed.preload(:last_entry, :tags)
                 .search(params.dig(:query, :keyword)).recent
                 .pager(page: params[:page], per: PER_PAGE)
    response = @feeds.map { |feed| ::Api::Feed.new(feed: feed).attributes }
    render json: response
  end
end
