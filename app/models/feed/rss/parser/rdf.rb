module Feed::Rss
  class Parser::Rdf
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
      @items = parsed_xml.items.map { |item| build_parsed_item(item) }
    end

    def header
      @header ||= build_parsed_header(parsed_xml.channel)
    end

    def build_parsed_header(channel)
      ParsedHeader.new(
        title: channel.title,
        description: shaped_description(channel.description),
        link: channel.link
      )
    end

    def build_parsed_item(item)
      ParsedItem.new(
        title: item.title,
        description: shaped_description(item.description),
        published_at: item.dc_date,
        link: item.link,
        eye_catching_image: nil
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
