module Feed::Rss
  class InValidHeader < StandardError; end

  class ParsedHeader
    def initialize(title:, link:, description:)
      @title = title
      @link = link
      @description = description
      tap { validate! }
    end

    attr_reader :title, :link, :description

    def attributes
      { title: title, link: link, description: description }
    end

    private

    def validate!
      raise InValidHeader if title.nil?
    end
  end
end
