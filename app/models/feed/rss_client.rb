class Feed::RssClient
  def initialize(endpoint)
    @endpoint = endpoint
    @rss_source = Net::HTTP.get(URI.parse(endpoint))
  end

  attr_reader :endpoint, :rss_source

  def parsed_rss!
    RSS::Parser.parse(rss_source)
  rescue RSS::InvalidRSSError
    RSS::Parser.parse(rss_source, false)
  end

  def parsed_items
    parsed_xml = parsed_rss!
    case parsed_xml.class.name
    when 'RSS::Atom::Feed' then Feed::EntryParser::Atom.call(parsed_xml)
    when 'RSS::Rss' then Feed::EntryParser::Rss.call(parsed_xml)
    else []
    end
  end
end
