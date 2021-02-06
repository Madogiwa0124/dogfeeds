class Api::FeedsController < ApplicationController
  PER_PAGE = 12

  def index
    @feeds = Feed.preload(:last_entry, :tags).search(**search_params).recent
    @feeds = @feeds.pager(page: params[:page], per: PER_PAGE) if params[:page].present?
    response = @feeds.map { |feed| ::Api::Feed.new(feed: feed).attributes }
    render json: response
  end

  def show
    feed = ::Api::Feed.new(feed: Feed.preload(:tags, :last_entry).find(params[:id]))
    render json: feed.attributes
  end

  private

  def search_params
    { keyword: params.dig(:query, :keyword), ids: params[:ids] }
  end
end
