xml.instruct! :xml, version: '1.0'
xml.rss(version: '2.0') do
  xml.channel do
    xml.title @board.title
    xml.description 'dogfeed!'
    xml.link 'http://localhost:3000/boards/'
    xml.lastBuildDate @entries.last.published_at.rfc2822
    xml.language 'ja'
    xml.copyright '© copyright 2019 Madogiwa All Rights Reserved.'
    @entries.each do |entry|
      xml.item do
        xml.title entry.title
        xml.description entry.description
        xml.pubDate entry.published_at.rfc2822
        xml.link entry.link
      end
    end
  end
end
