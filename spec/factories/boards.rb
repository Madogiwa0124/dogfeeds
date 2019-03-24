# == Schema Information
#
# Table name: boards
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :board do
    title { 'Board Title' }
  end

  trait :with_feeds do
    after(:create) do |board|
      create_list(:board_feed, 3, board: board)
    end
  end
end
