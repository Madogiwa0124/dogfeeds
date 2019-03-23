class Feed::EntryParser::ParsedItem
  def initialize(
    description:,
    eye_catching_image:,
    link:,
    published_at:,
    title:
  )
    @description = description
    @eye_catching_image = eye_catching_image
    @link = link
    @published_at = published_at
    @title = title
  end

  attr_reader :description, :eye_catching_image, :link, :published_at, :title

  def attributes
    { description: description,
      eye_catching_image: eye_catching_image,
      link: link,
      published_at: published_at,
      title: title }
  end
end
