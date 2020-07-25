module Feed::Rss
  class InValidItem < StandardError; end

  class ParsedItem
    def initialize(description:, eye_catching_image:, link:, published_at:, title:)
      @description = description
      @eye_catching_image = eye_catching_image
      @link = link
      @published_at = published_at
      @title = title
      tap { validate! }
    end

    attr_reader :description, :eye_catching_image, :link, :published_at, :title

    def attributes
      { description: description,
        eye_catching_image: eye_catching_image,
        link: link,
        published_at: published_at,
        title: title }
    end

    private

    def validate!
      raise InValidItem if [title, description, link, published_at].include? nil
    end
  end
end
