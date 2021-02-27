require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '#last_entry' do
    let(:board) { create(:board) }
    let(:last_entries) { create_list(:entry, 2, published_at: Time.current) }

    before do
      board.strict_loading!(false)
      create(:entry, feed: last_entries[0].feed, published_at: 1.day.ago)
      create(:entry, feed: last_entries[1].feed, published_at: 1.day.ago)
      board.board_feeds.create(feed: last_entries[0].feed)
      board.board_feeds.create(feed: last_entries[1].feed)
    end

    it 'Feed別に最新の公開日時を持つEntryが取得されること' do
      expect(board.last_entries.first).to eq board.last_entry
    end
  end

  describe '#description' do
    let(:board) { create(:board) }
    let(:description) { '「タイトル1、タイトル2」をまとめたRSSフィードです。' }

    before do
      board.strict_loading!(false)
      board.board_feeds.create(feed: create(:feed, title: 'タイトル1'))
      board.board_feeds.create(feed: create(:feed, title: 'タイトル2'))
    end

    it 'フィードのタイトルを結合した文言が取得出来ること' do
      expect(board.description).to eq description
    end

    context '紐づくFeedの数が5件を超える場合' do
      let(:description) { '「タイトル1、タイトル2、タイトル3、タイトル4、タイトル5 ...」をまとめたRSSフィードです。' }

      before do
        board.board_feeds.create(feed: create(:feed, title: 'タイトル3'))
        board.board_feeds.create(feed: create(:feed, title: 'タイトル4'))
        board.board_feeds.create(feed: create(:feed, title: 'タイトル5'))
        board.board_feeds.create(feed: create(:feed, title: 'タイトル6'))
      end

      it '6件目は省略されてフィードのタイトルを結合した文言が取得出来ること' do
        expect(board.description).to eq description
      end
    end
  end

  describe '.create_with_board_feeds!' do
    let(:feeds) { create_list(:feed, 3) }

    context 'タイトルが指定されていない場合' do
      let(:args) { { feeds: feeds, title: nil } }

      it 'デフォルトのタイトルでboadとfeedが作成されること' do
        board = described_class.create_with_board_feeds!(**args)
        board.strict_loading!(false)
        expect(board.title).to eq '無題のボード'
        expect(board.feeds).to match_array feeds
      end
    end

    context 'タイトルが指定されている場合' do
      let(:args) { { feeds: feeds, title: 'title' } }

      it '指定したタイトルでboadとfeedが作成されること' do
        board = described_class.create_with_board_feeds!(**args)
        board.strict_loading!(false)
        expect(board.title).to eq 'title'
        expect(board.feeds).to match_array feeds
      end
    end
  end

  describe '#recreate_board_feeds' do
    let(:feeds) { create_list(:feed, 3) }
    let(:board) { create(:board, :with_feeds) }

    it '引数で渡されたidを持つfeedsに書き換わること' do
      board.strict_loading!(false)
      board.recreate_board_feeds!(feeds.map(&:id))
      expect(board.feeds).to match_array feeds
    end
  end
end
