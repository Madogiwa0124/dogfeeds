module Feed::Rss
  class Parser::Atom
    def self.call(parsed_xml)
      new.call(parsed_xml)
    end

    def call(parsed_xml)
      @parsed_xml = parsed_xml
      ParsedObject.new(header: header, items: items)
    end

    private

    attr_reader :parsed_xml

    def items
      @items ||= parsed_xml.entries.map { |entry| build_parsed_item(entry) }
    end

    def header
      @header ||= build_parsed_header(parsed_xml)
    end

    def build_parsed_header(feed)
      ParsedHeader.new(
        title: feed.title.content,
        description: nil, # MEMO: Atomにdescriptionがなさそうなので一旦NULLを設定
        link: feed.link.href
      )
    end

    def build_parsed_item(item)
      ParsedItem.new(
        title: item.title.content,
        description: shaped_description(item.content.content),
        published_at: item.published.content,
        link: item.link.href,
        eye_catching_image: nil # MEMO: AtomにアイキャッチのURLなさそうなので一旦NULLを設定
      )
    end

    def shaped_description(description)
      strip_tags(description.to_s.gsub(/[\r\n]/, '')).truncate(300)
    end

    def strip_tags(text)
      ::ActionController::Base.helpers.strip_tags text
    end
  end
end
