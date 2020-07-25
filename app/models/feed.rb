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

  URI_REGEXP_PATTERN = URI::DEFAULT_PARSER.make_regexp(%w[http https]).freeze

  has_many :entries, dependent: :destroy
  has_one :last_entry, -> { recent }, class_name: 'Entry', inverse_of: :feed
  has_many :board_feeds, dependent: :destroy
  has_many :boards, through: :board_feeds
  has_many :feed_taggings, dependent: :destroy
  has_many :tags, through: :feed_taggings, class_name: 'FeedTag', source: :feed_tag

  attribute :client_class, default: Feed::Rss::Client

  validates :title, presence: true
  # TODO: 開発が落ち着いて安定してきたらDBレベルでのuniq制約をつける
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :endpoint, presence: true, format: URI_REGEXP_PATTERN, uniqueness: true
  # rubocop:enable Rails/UniqueValidationWithoutIndex

  scope :recent, -> { order(last_published_at: :desc, id: :desc) }
  scope :titled_by, ->(keyword) {
    where('title LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  }
  scope :pager, ->(page: 1, per: 10) {
    num = page.to_i.positive? ? page.to_i - 1 : 0
    limit(per).offset(per * num)
  }
  scope :tagged_by, ->(tags) {
    where(id: FeedTagging.where(feed_tag_id: tags).select(:feed_id))
  }
  scope :search, ->(keyword) {
    return all if keyword.blank?

    titled_by(keyword).or(tagged_by(FeedTag.where(body: keyword)))
  }

  def parsed_items
    @parsed_items ||= parsed_object ? parsed_object.items : []
  end

  def parsed_header_title
    @parsed_header_title ||= parsed_object ? parsed_object.header.title : ''
  end

  private

  def parsed_object
    @parsed_object ||= client_class.new(endpoint).parsed_object
  rescue RSS::NotWellFormedError => e
    logger.error(e)
    invalid_rss_format
    nil # NOTE: rescueされたときにerrorsが返却されてしまうのでnilを返して呼び元で判定できるようにしてる
  end

  def invalid_rss_format
    errors.add(:base, 'rssフィードの形式が不正です。エンドポイントをご確認ください。')
  end
end
