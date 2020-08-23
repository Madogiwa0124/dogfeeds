require 'rails_helper'

RSpec.describe Api::Entry, type: :model do
  describe '#attribute' do
    let!(:entry) { create(:entry) }

    it 'EntryのHashが取得できること' do
      expect(Api::Entry.new(entry: entry).attributes).to eq(
        {
          id: entry.id,
          description: entry.description.to_s,
          eyeCatchingImage: entry.eye_catching_image,
          link: entry.link,
          publishedAt: entry.published_at.iso8601,
          title: entry.title,
          feedId: entry.feed_id
        }
      )
    end
  end
end
