class Api::FeedsController < ApplicationController
  PER_PAGE = 6

  def index
    @feeds = Feed.recent.pager(page: params[:page], per: PER_PAGE)
    @last_entries = @feeds.includes(:last_entry).map(&:last_entry)
    object = { feeds: @feeds, last_entries: @last_entries, tags: tags }
    render json: object
  end

  def tags
    taggings = FeedTagging.where(feed: @feeds).includes(:feed_tag)
    taggings.map do |tagging|
      { feed_id: tagging.feed_id, body: tagging.feed_tag.body }
    end
  end
end
