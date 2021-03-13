FactoryBot.define do
  factory :entry do
    feed
    title { 'Title' }
    link { 'Link' }
    description { ['aaa', nil].sample }
    published_at { Time.current }
    strict_loaded
  end
end
