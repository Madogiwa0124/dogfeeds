FactoryBot.define do
  factory :board do
    title { 'Board Title' }
    strict_loaded
  end

  trait :with_feeds do
    after(:create) do |board|
      create_list(:board_feed, 3, board: board)
    end
  end
end
