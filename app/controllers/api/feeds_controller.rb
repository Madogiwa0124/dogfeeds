class Api::FeedsController < ApplicationController
  PER_PAGE = 6

  def index
    @feeds = Feed.search(params.dig(:query, :keyword)).recent
                 .pager(page: params[:page], per: PER_PAGE)
    @last_entries = @feeds.preload(:last_entry).map(&:last_entry)
    render json: { feeds: @feeds, last_entries: @last_entries, tags: tags }
  end

  private

  def tags
    taggings = FeedTagging.where(feed: @feeds).preload(:feed_tag)
    taggings.map do |tagging|
      { feed_id: tagging.feed_id, body: tagging.feed_tag.body }
    end
  end
end
