# == Schema Information
#
# Table name: entries
#
#  id                 :bigint(8)        not null, primary key
#  description        :text
#  eye_catching_image :string
#  link               :string
#  published_at       :datetime
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  feed_id            :bigint(8)
#
# Indexes
#
#  index_entries_on_feed_id  (feed_id)
#

class Entry < ApplicationRecord
  belongs_to :feed

  validates :title, presence: true
  validates :link, presence: true
end
