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
    let!(:feed_3) { create(:feed, last_published_at: 3.days.ago) }

    it '最終公開日時の降順にソートされること' do
      expect(described_class.recent).to eq [feed_1, feed_2, feed_3]
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
    let(:feed) { build(:feed, endpoint: endpoint) }

    context '正しいendpointの場合' do
      let(:endpoint) { 'https://madogiwa0124.hatenablog.com/rss' }

      it 'Parseされた記事の一覧が取得出来ること' do
        expect(feed.parsed_items.length).to be_positive
      end
    end

    context '不正なendpointの場合' do
      let(:endpoint) { 'https://madogiwa0124.hatenablog.com' }
      let(:mssages) { 'rssフィードの形式が不正です。エンドポイントをご確認ください。' }

      before { feed.parsed_items }

      it 'errorが発生すること' do
        expect(feed.errors.messages[:base]).to include(mssages)
      end
    end
  end
end
