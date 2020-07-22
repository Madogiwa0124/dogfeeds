module Api
  class Feed
    def initialize(feed:)
      @feed = feed
      @entry = feed.last_entry
      @tags = feed.tags
    end

    attr_reader :feed, :entry, :tags

    def attributes
      {
        id: feed.id,
        endpoint: feed.endpoint,
        lastPublishedAt: feed.last_published_at.iso8601,
        title: feed.title,
        lastEntry: entry ? entry_attributes : nil,
        tags: tags.map { |tag| tag_attributes(tag) }
      }
    end

    private

    def entry_attributes
      {
        id: entry.id,
        description: entry.description,
        eyeCatchingImage: entry.eye_catching_image,
        link: entry.link,
        publishedAt: entry.published_at.iso8601,
        title: entry.title,
        feedId: entry.feed_id
      }
    end

    def tag_attributes(tag)
      {
        id: tag.id,
        body: tag.body,
        feedId: feed.id
      }
    end
  end
end
