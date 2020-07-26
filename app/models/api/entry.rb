module Api
  class Entry
    def initialize(entry:)
      @entry = entry
    end

    attr_reader :entry

    def attributes
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
  end
end
