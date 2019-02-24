class Feed::EntryCreater
  attr_reader :feed

  def initialize(feed)
    @feed = feed
  end

  def execute!
    Entry.where(feed: feed).delete_all
    feed.parsed_xml.items.map { |item| create_entry!(item) }
  end

  private

  def create_entry!(item)
    Entry.create!(
      feed: feed,
      title: item.title,
      description: shaped_description(item.description),
      published_at: item.pubDate,
      link: item.link,
      eye_catching_image: item.enclosure&.url
    )
  end

  def shaped_description(description)
    strip_tags(description.gsub(/[\r\n]/, '')).truncate(300)
  end

  def strip_tags(text)
    ActionController::Base.helpers.strip_tags text
  end
end
