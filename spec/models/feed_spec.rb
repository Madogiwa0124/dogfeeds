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
  describe '.recent' do
    let!(:feed_1) { create(:feed, last_published_at: 1.day.ago) }
    let!(:feed_2) { create(:feed, last_published_at: 2.days.ago) }
    let!(:feed_3) { create(:feed, last_published_at: 2.days.ago) }

    it '最終公開日時、IDの降順にソートされること' do
      expect(described_class.recent).to eq [feed_1, feed_3, feed_2]
    end
  end

  describe '.titled_by' do
    let!(:feed) { create(:feed, title: 'hoge') }
    before { create(:feed, title: 'fuga') }

    it '検索文字列を含むfeedが取得されること' do
      expect(described_class.titled_by('ho')).to eq [feed]
    end
  end

  describe '.tagged_by' do
    let!(:feed) { create(:feed, title: 'hoge') }
    let!(:tag) { create(:feed_tag, body: 'tag1') }

    before do
      create(:feed, title: 'fuga')
      create(:feed_tagging, feed: feed, feed_tag: tag)
    end

    it 'タグが設定されたfeedが取得されること' do
      expect(described_class.tagged_by(tag)).to eq [feed]
    end
  end

  describe '.search' do
    let!(:titled_feed) { create(:feed, title: 'hoge') }
    let!(:tagged_feed) { create(:feed, title: 'fuga') }
    let!(:not_target_feed) { create(:feed, title: 'piyo') }
    let!(:tag) { create(:feed_tag, body: 'ho') }

    before { create(:feed_tagging, feed: tagged_feed, feed_tag: tag) }
    subject { described_class.search('ho') }

    it '検索文字列が含まれたタイトルを持つfeedが取得されること' do
      is_expected.to include titled_feed
    end

    it '検索文字列のタグが設定されたfeedが取得されること' do
      is_expected.to include tagged_feed
    end

    it 'それ以外のfeedは検索結果に含まれないこと' do
      is_expected.to_not include not_target_feed
    end
  end

  describe 'pager' do
    let!(:feed_1) { create(:feed, last_published_at: 4.days.ago) }
    let!(:feed_2) { create(:feed, last_published_at: 3.days.ago) }
    let!(:feed_3) { create(:feed, last_published_at: 2.days.ago) }
    let!(:feed_4) { create(:feed, last_published_at: 1.day.ago) }
    let(:result) do
      described_class.order(:last_published_at).pager(page: page, per: 2)
    end

    context 'pageが0の場合' do
      let(:page) { 0 }

      it '1ページ目が検索されること' do
        expect(result.first).to eq feed_1
        expect(result.last).to eq feed_2
      end
    end

    context 'pageが2の場合' do
      let(:page) { 2 }

      it '2ページ目が検索されること' do
        expect(result.first).to eq feed_3
        expect(result.last).to eq feed_4
      end
    end
  end

  describe '#parsed_items' do
    include RssMockHelper
    let(:feed) { build(:feed) }

    context '正しいRSS形式の場合' do
      before do
        valid_body = File.read(Rails.root.join('spec/sample/rss.xml'))
        rss_mock_enable(resource: valid_body)
      end

      it 'Parseされた記事の一覧が取得出来ること' do
        expect(feed.parsed_items.length).to eq 2
        expect(feed.parsed_items.map(&:title)).to eq ['title 1', 'title 2']
      end
    end

    context '不正なRSS形式の場合' do
      let(:mssages) { 'rssフィードの形式が不正です。エンドポイントをご確認ください。' }

      before do
        invald_body = '<html invald format</html>'
        rss_mock_enable(resource: invald_body)
      end

      it 'エラーメッセージが設定されること' do
        feed.parsed_items
        expect(feed.errors.messages[:base]).to include(mssages)
      end

      it '空配列が返却されること' do
        feed.parsed_items
        expect(feed.parsed_items).to eq []
      end
    end
  end

  describe '#parsed_header_title' do
    include RssMockHelper
    let(:feed) { build(:feed) }

    context '正しいRSS形式の場合' do
      before do
        valid_body = File.read(Rails.root.join('spec/sample/rss.xml'))
        rss_mock_enable(resource: valid_body)
      end

      it 'ParseされたRSSのタイトルが取得されること' do
        expect(feed.parsed_header_title).to eq 'Example Rss'
      end

      context '不正なRSS形式の場合' do
        before do
          invald_body = '<html invald format</html>'
          rss_mock_enable(resource: invald_body)
        end

        it '空文字が返却されること' do
          expect(feed.parsed_header_title).to eq ''
        end
      end
    end
  end
end
