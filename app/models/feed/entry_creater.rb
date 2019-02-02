class Feed::EntryCreater
  attr_reader :feed

  def initialize(feed)
    @feed = feed
  end

  def execute
    feed.parsed_xml.items.map do |item|
      Entry.where(feed: feed).delete_all
      Entry.create(feed: feed, title: item.title, published_at: item.pubDate, link: item.link)
    end
  end
end
