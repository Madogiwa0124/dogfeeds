# == Schema Information
#
# Table name: feeds
#
#  id                :bigint(8)        not null, primary key
#  endpoint          :string           not null
#  last_published_at :datetime
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Feed < ApplicationRecord
  require 'rss'

  URI_REGEXP_PATTERN = /\A#{URI.regexp(%w[http https])}\z/.freeze

  has_many :entries, dependent: :destroy
  has_one :last_entry, -> { recent }, class_name: 'Entry', inverse_of: :feed
  has_many :board_feeds, dependent: :destroy
  has_many :boards, through: :board_feeds

  validates :title, presence: true
  validates :endpoint, presence: true, format: URI_REGEXP_PATTERN

  scope :recent, -> { order(last_published_at: :desc) }
  scope :pager, ->(page: 1, per: 10) {
    num = page.to_i.positive? ? page.to_i - 1 : 0
    limit(per).offset(per * num)
  }

  def save_with_entry_create!(params)
    assign_attributes(params)
    save!
    Feed::EntryCreater.new(self).execute!
  rescue StandardError => e
    faild_entries_create
    raise e
  end

  def parsed_items
    Feed::RssClient.new(endpoint).parsed_items
  rescue RSS::NotWellFormedError => e
    logger.error(e)
    invalid_rss_format
  end

  private

  def faild_entries_create
    errors.add(:base, '記事の一覧を取得するのに失敗しました。')
  end

  def invalid_rss_format
    errors.add(:base, 'rssフィードの形式が不正です。エンドポイントをご確認ください。')
  end
end
