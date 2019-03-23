class Feed::EntryParser::Rss
  def self.call(parsed_xml)
    new.call(parsed_xml)
  end

  def call(parsed_xml)
    @parsed_xml = parsed_xml
    items
  end

  attr_reader :parsed_xml

  def items
    @items = parsed_xml.items.map { |item| build_parsed_item(item) }
  end

  def build_parsed_item(item)
    Feed::EntryParser::ParsedItem.new(
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
