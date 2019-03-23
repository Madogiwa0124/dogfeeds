class Feed::EntryParser::Atom
  def self.call(parsed_xml)
    new.call(parsed_xml)
  end

  def call(parsed_xml)
    @parsed_xml = parsed_xml
    items
  end

  attr_reader :parsed_xml

  def items
    @items = parsed_xml.entries.map { |entry| build_parsed_item(entry) }
  end

  def build_parsed_item(item)
    Feed::EntryParser::ParsedItem.new(
      title: item.title.content,
      description: shaped_description(item.content.content),
      published_at: item.published.content,
      link: item.link.href,
      eye_catching_image: nil # MEMO: AtomにアイキャッチのURLなさそうなので一旦NULLを設定
    )
  end

  def shaped_description(description)
    strip_tags(description.gsub(/[\r\n]/, '')).truncate(300)
  end

  def strip_tags(text)
    ActionController::Base.helpers.strip_tags text
  end
end
