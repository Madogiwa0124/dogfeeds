module Feed::Rss
  class Client
    def initialize(endpoint)
      @endpoint = endpoint
    end

    def parsed_object
      @parsed_object ||= case parsed_rss.class.name
      when 'RSS::Atom::Feed' then Parser::Atom.call(parsed_rss)
      when 'RSS::Rss' then Parser::Rss.call(parsed_rss)
      end
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
