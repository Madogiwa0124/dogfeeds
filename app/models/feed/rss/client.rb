module Feed::Rss
  class Client
    PARSERS = {
      'RSS::Atom::Feed' => Parser::Atom,
      'RSS::Rss' => Parser::Rss,
      'RSS::RDF' => Parser::Rdf
    }.freeze

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def parsed_object
      @parsed_object ||= PARSERS[parsed_rss.class.name].call(parsed_rss)
    end

    private

    attr_reader :endpoint

    def resource
      @resource ||= Net::HTTP.get(URI.parse(endpoint))
    end

    def parse!
      RSS::Parser.parse(resource)
    rescue RSS::InvalidRSSError
      RSS::Parser.parse(resource, false)
    end

    def parsed_rss
      @parsed_rss ||= parse!
    end
  end
end
