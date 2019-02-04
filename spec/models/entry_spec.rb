# == Schema Information
#
# Table name: entries
#
#  id                 :bigint(8)        not null, primary key
#  description        :text
#  eye_catching_image :string
#  link               :string
#  published_at       :datetime
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  feed_id            :bigint(8)
#
# Indexes
#
#  index_entries_on_feed_id  (feed_id)
#

require 'rails_helper'

RSpec.describe Entry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
