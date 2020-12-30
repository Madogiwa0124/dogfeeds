# == Schema Information
#
# Table name: feed_tags
#
#  id         :bigint(8)        not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FeedTag < ApplicationRecord
  has_many :feed_taggings, dependent: :destroy
  has_many :feeds, through: :feed_taggings

  def self.counted_tags(limit:)
    joins(:feed_taggings)
      .group('feed_tags.body')
      .order('count_all DESC')
      .limit(limit)
      .count
      .map { |body, count| { body: body, count: count } }
  end
end
