# == Schema Information
#
# Table name: board_feeds
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint(8)
#  feed_id    :bigint(8)
#
# Indexes
#
#  index_board_feeds_on_board_id  (board_id)
#  index_board_feeds_on_feed_id   (feed_id)
#

FactoryBot.define do
  factory :board_feed do
    
  end
end
