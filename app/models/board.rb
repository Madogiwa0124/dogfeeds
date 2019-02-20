# == Schema Information
#
# Table name: boards
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ApplicationRecord
  require 'rss'

  has_many :board_feeds, dependent: :destroy
  has_many :feeds, through: :board_feeds
  has_many :entries, through: :feeds

  def self.create_with_board_feeds!(title: '無題のボード', feeds:)
    ActiveRecord::Base.transaction do
      board = create!(title: title)
      feeds.each { |feed| board.board_feeds.create!(feed: feed) }
      board
    end
  end

  def to_rss
    RSS::Maker.make("2.0") do |feed|
      feed.channel.title = title
      feed.channel.link = 'http://localhost:3000/boards/'
      feed.channel.about = 'dogfeeds!!'
      feed.channel.description = "dogfeeds description!!"
      feed.channel.updated = entries.recent.last.updated_at

      entries.each do |entry|
        feed.items.new_item do |item|
          item.title = article.title
          item.description = article.description
        end
      end
    end
  end
end
