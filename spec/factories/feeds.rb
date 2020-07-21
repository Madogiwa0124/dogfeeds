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
    endpoint { 'https://example.com/rss' }

    trait :with_entry do
      after(:create) do |feed, _evaluator|
        create(:entry, feed: feed)
      end
    end
  end
end
