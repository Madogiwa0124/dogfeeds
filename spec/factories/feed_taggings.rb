# == Schema Information
#
# Table name: feed_taggings
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  feed_id     :bigint(8)
#  feed_tag_id :bigint(8)
#
# Indexes
#
#  index_feed_taggings_on_feed_id      (feed_id)
#  index_feed_taggings_on_feed_tag_id  (feed_tag_id)
#

FactoryBot.define do
  factory :feed_tagging do
    feed
    feed_tag
  end
end
