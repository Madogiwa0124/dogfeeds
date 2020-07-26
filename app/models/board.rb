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

  MAX_DISPLAY_FEED = 5

  has_many :board_feeds, dependent: :destroy
  has_many :feeds, through: :board_feeds
  has_many :entries, through: :feeds
  has_many :last_entries, through: :feeds, source: :last_entry

  def last_entry
    @last_entry ||= last_entries.first
  end

  def description
    # NOTE: 表示件数より多くのFeedを持つことをチェックするために+1した件数を取得する
    display_feeds = feeds.first(MAX_DISPLAY_FEED + 1)
    omission = display_feeds.length > MAX_DISPLAY_FEED ? ' ...' : ''
    "「#{display_feeds.first(MAX_DISPLAY_FEED).map(&:title).join('、')}#{omission}」をまとめたRSSフィードです。"
  end

  def self.create_with_board_feeds!(title:, feeds:)
    ActiveRecord::Base.transaction do
      board = create!(title: title.presence || '無題のボード')
      feeds.each { |feed| board.board_feeds.create!(feed: feed) }
      board
    end
  end

  def recreate_board_feeds!(feed_ids)
    ActiveRecord::Base.transaction do
      board_feeds.destroy_all
      feed_ids.each { |feed_id| board_feeds.create!(feed_id: feed_id) }
    end
  end
end
