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
  validates :title, presence: true
  validates :endpoint, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
