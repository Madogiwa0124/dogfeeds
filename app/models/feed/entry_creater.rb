class Feed::EntryCreater
  attr_reader :feed

  def initialize(feed)
    @feed = feed
  end

  def execute
    Entry.where(feed: feed).delete_all
    feed.parsed_xml.items.map do |item|
      Entry.create(
        feed: feed,
        title: item.title,
        description: strip_tags(item.description).truncate(300),
        published_at: item.pubDate,
        link: item.link
      )
    end
  end

  private

  def strip_tags(text)
    ActionController::Base.helpers.strip_tags text
  end
end
