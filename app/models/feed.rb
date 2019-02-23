# == Schema Information
#
# Table name: feeds
#
#  id         :bigint(8)        not null, primary key
#  endpoint   :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
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

  def save_with_entry_create!(params)
    assign_attributes(params)
    save!
    Feed::EntryCreater.new(self).execute!
  end

  def parsed_xml
    xml = Net::HTTP.get(URI.parse(endpoint))
    RSS::Parser.parse(xml)
  end
end
