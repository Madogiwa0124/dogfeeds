class Feed::Rss::ParsedObject
  def initialize(header:, items:)
    @header = header
    @items = items
  end

  attr_reader :header, :items
end
