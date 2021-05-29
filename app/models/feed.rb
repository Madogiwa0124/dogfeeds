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
  include Pagerable
  require 'rss'

  URI_REGEXP_PATTERN = URI::DEFAULT_PARSER.make_regexp(%w[http https]).freeze

  has_many :entries, dependent: :destroy
  has_one :last_entry, -> { recent }, class_name: 'Entry', inverse_of: :feed
  has_many :recent_entries, -> { recent }, class_name: 'Entry', inverse_of: :feed
  has_many :board_feeds, dependent: :destroy
  has_many :boards, through: :board_feeds
  has_many :feed_taggings, dependent: :destroy
  has_many :tags, through: :feed_taggings, class_name: 'FeedTag', source: :feed_tag

  attribute :client_class, default: Feed::Rss::Client

  validates :title, presence: true
  # TODO: 開発が落ち着いて安定してきたらDBレベルでのuniq制約をつける
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :endpoint, presence: true, uniqueness: true
  # rubocop:enable Rails/UniqueValidationWithoutIndex
  validates :endpoint, format: URI_REGEXP_PATTERN, allow_blank: true

  scope :recent, -> { order(last_published_at: :desc, id: :desc) }
  scope :titled_by, ->(keyword) {
    where('title LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  }
  scope :tagged_by, ->(tags) {
    where(id: FeedTagging.where(feed_tag_id: tags).select(:feed_id))
  }
  scope :search, ->(keyword: '', ids: []) {
    fillters = [
      ->(relation) {
        return relation if keyword.blank?
        relation.titled_by(keyword).or(tagged_by(FeedTag.where(body: keyword)))
      },
      ->(relation) { ids.present? ? relation.where(id: ids) : relation }
    ]
    fillters.inject(all) { |result, filter| filter.call(result) }
  }

  def parsed_items
    @parsed_items ||= parsed_object ? parsed_object.items : []
  end

  def parsed_header_title
    @parsed_header_title ||= parsed_object ? parsed_object.header.title : ''
  end

  private

  def parsed_object
    return nil if endpoint.blank?
    @parsed_object ||= client_class.new(endpoint).parsed_object
  rescue RSS::NotWellFormedError => error
    logged_error error.exception("#{error.message} raised from endpoint: #{endpoint}")
    invalid_rss_format
    nil # NOTE: rescueされたときにerrorsが返却されてしまうのでnilを返して呼び元で判定できるようにしてる
  end

  def logged_error(raised_error)
    logger.warn(raised_error)
    Rollbar.warning(raised_error)
  end

  def invalid_rss_format
    errors.add(:base, 'RSSフィードの形式が不正です。エンドポイントをご確認ください。')
  end
end
