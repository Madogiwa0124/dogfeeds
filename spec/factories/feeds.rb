FactoryBot.define do
  factory :feed do
    sequence(:title) { |n| "title_#{n}" }
    last_published_at { Time.current }
    sequence(:endpoint) { |n| "https://#{n}.example.com/rss" }

    trait :with_entry do
      after(:create) do |feed, _evaluator|
        create(:entry, feed: feed)
      end
    end

    trait :with_tag do
      transient do
        tag_body { 'tag_body' }
      end

      after(:create) do |feed, evaluator|
        tag = create(:feed_tag, body: evaluator.tag_body)
        create(:feed_tagging, feed: feed, feed_tag: tag)
      end
    end
  end
end
