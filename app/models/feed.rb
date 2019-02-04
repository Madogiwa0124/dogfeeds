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

  has_many :entries
  has_one :last_entry, ->{ order(published_at: :desc) }, class_name: 'Entry'

  validates :title, presence: true
  validates :endpoint, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/

  def parsed_xml
    xml = Net::HTTP.get(URI.parse(endpoint))
    RSS::Parser.parse(xml)
  end
end
