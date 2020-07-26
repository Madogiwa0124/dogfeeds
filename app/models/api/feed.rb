module Api
  class Feed
    def initialize(feed:)
      @feed = feed
      @last_entry = feed.last_entry
      @tags = feed.tags
    end

    attr_reader :feed, :last_entry, :tags

    def attributes
      {
        id: feed.id,
        endpoint: feed.endpoint,
        lastPublishedAt: feed.last_published_at.iso8601,
        title: feed.title,
        lastEntry: last_entry_attirbutes,
        tags: tags_attributes
      }
    end

    private

    def last_entry_attirbutes
      last_entry ? Entry.new(entry: last_entry).attributes : nil
    end

    def tags_attributes
      tags.map { |tag| tag_attributes(tag) }
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
