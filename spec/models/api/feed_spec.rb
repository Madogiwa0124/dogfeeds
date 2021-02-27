require 'rails_helper'

RSpec.describe Api::Feed, type: :model do
  describe '#attribute' do
    let!(:feed) { create(:feed) }

    context 'Tag、Entryを持つ場合' do
      let!(:entry) { create(:entry, feed: feed) }
      let!(:tag) { create(:feed_tag) }

      before { create(:feed_tagging, feed: feed, feed_tag: tag) }

      it 'Tag、Entryを含んだFeedのHashが取得できること' do
        feed.strict_loading!(false)
        expect(Api::Feed.new(feed: feed).attributes).to eq(
          {
            id: feed.id,
            endpoint: feed.endpoint,
            lastPublishedAt: feed.last_published_at.iso8601,
            title: feed.title,
            lastEntry: {
              id: entry.id,
              description: entry.description.to_s,
              eyeCatchingImage: entry.eye_catching_image,
              link: entry.link,
              publishedAt: entry.published_at.iso8601,
              title: entry.title,
              feedId: entry.feed_id
            },
            tags: [{
              id: tag.id,
              body: tag.body,
              feedId: feed.id
            }]
          }
        )
      end
    end

    context 'Tag、Entryが無い場合' do
      it 'Tagは空配列、EntryはnilでFeedのHashが取得できること' do
        feed.strict_loading!(false)
        expect(Api::Feed.new(feed: feed).attributes).to eq(
          {
            id: feed.id,
            endpoint: feed.endpoint,
            lastPublishedAt: feed.last_published_at.iso8601,
            title: feed.title,
            lastEntry: nil,
            tags: []
          }
        )
      end
    end
  end
end
