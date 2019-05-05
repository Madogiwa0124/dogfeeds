# == Schema Information
#
# Table name: feed_tags
#
#  id         :bigint(8)        not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :feed_tag do
    body { 'test' }
  end
end
