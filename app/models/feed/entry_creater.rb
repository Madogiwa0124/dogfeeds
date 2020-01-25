class Feed::EntryCreater
  attr_reader :feed

  def initialize(feed)
    @feed = feed
  end

  def execute!
    Entry.where(feed: feed).delete_all
    Entry.insert_all!(target_entries)
    feed.update!(last_published_at: feed.last_entry.published_at)
  end

  private

  def target_entries
    feed.parsed_items.map do |item|
      now = Time.current
      item.attributes.merge(feed_id: feed.id, created_at: now, updated_at: now)
    end
  end
end
