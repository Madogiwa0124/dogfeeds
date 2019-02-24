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

  def self.create_with_board_feeds!(title:, feeds:)
    ActiveRecord::Base.transaction do
      board = create!(title: title.presence || '無題のボード')
      feeds.each { |feed| board.board_feeds.create!(feed: feed) }
      board
    end
  end
end
