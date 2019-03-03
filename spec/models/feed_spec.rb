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

require 'rails_helper'

RSpec.describe Feed, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
