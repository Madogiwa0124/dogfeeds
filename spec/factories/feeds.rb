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

FactoryBot.define do
  factory :feed do
    sequence(:title) { |n| "title_#{n}" }
    last_published_at { Time.current }
    endpoint { 'https://madogiwa0124.hatenablog.com/rss' }
  end
end
