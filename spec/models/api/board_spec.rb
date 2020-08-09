require 'rails_helper'

RSpec.describe Api::Board, type: :model do
  describe '#attribute' do
    let!(:board) { create(:board, :with_feeds) }

    context 'Entryを持つ場合' do
      let!(:entry) { create(:entry, feed: board.feeds.take) }

      it 'Entryを含んだBoardのHashが取得できること' do
        expect(Api::Board.new(board: board).attributes).to eq(
          {
            id: board.id,
            title: board.title,
            description: board.description,
            feedIds: board.feeds.ids,
            lastEntry: {
              id: entry.id,
              description: entry.description,
              eyeCatchingImage: entry.eye_catching_image,
              link: entry.link,
              publishedAt: entry.published_at.iso8601,
              title: entry.title,
              feedId: entry.feed_id
            }
          }
        )
      end
    end

    context 'Entryが無い場合' do
      it 'EntryはnilでBoardのHashが取得できること' do
        expect(Api::Board.new(board: board).attributes).to eq(
          id: board.id,
          title: board.title,
          description: board.description,
          feedIds: board.feeds.ids,
          lastEntry: nil
        )
      end
    end
  end
end
