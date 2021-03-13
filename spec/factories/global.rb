FactoryBot.define do
  trait :strict_loaded do
    after(:build) { |record| record.strict_loading!(false) }
  end
end
