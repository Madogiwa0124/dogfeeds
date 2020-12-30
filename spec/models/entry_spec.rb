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
