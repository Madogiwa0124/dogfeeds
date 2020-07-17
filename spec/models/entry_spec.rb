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
#  index_entries_on_feed_id       (feed_id)
#  index_entries_on_published_at  (published_at)
#

require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe '.recent' do
    let!(:entry_1) { create(:entry, published_at: 1.day.ago) }
    let!(:entry_2) { create(:entry, published_at: 2.days.ago) }
    let!(:entry_3) { create(:entry, published_at: 3.days.ago) }

    it '公開日時の降順でソートされること' do
      expect(described_class.recent).to eq [entry_1, entry_2, entry_3]
    end
  end
end
