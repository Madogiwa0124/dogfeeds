class Feed::EntryCreater
  attr_reader :feed

  def initialize(feed)
    @feed = feed
  end

  def execute!
    Entry.where(feed: feed).delete_all
    feed.parsed_items.map { |item| create_entry!(item) }
    feed.update!(last_published_at: feed.last_entry.published_at)
  end

  private

  def create_entry!(item)
    Entry.create!(item.attributes.merge(feed: feed))
  end
end
