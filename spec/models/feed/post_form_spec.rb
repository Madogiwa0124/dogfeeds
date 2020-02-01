require 'rails_helper'

RSpec.describe Feed::PostForm, type: :model do
  describe '#create!' do
    let(:title) { 'title' }
    let(:params) { { title: title, endpoint: endpoint, tags: tags } }
    let(:post_form) { described_class.new(params) }
    let(:feed) { Feed.find_by(title: title) }

    context '正常に終了した場合' do
      let(:endpoint) { 'https://madogiwa0124.hatenablog.com/rss' }
      before { post_form.create! }

      context 'タグが入力済みの場合' do
        let(:tags) { %w[tag1 tag2] }

        it '関連モデルと合わせてfeedが作成されること' do
          expect(feed.title).to eq title
          expect(feed.endpoint).to eq endpoint
          expect(feed.entries.length).to be_positive
          expect(feed.tags.pluck(:body)).to eq tags
        end
      end

      context 'タグが未入力の場合' do
        let(:tags) { nil }

        it '関連モデルと合わせてfeedが作成されること' do
          expect(feed.title).to eq title
          expect(feed.endpoint).to eq endpoint
          expect(feed.entries.length).to be_positive
          expect(feed.tags).to eq []
        end
      end
    end

    context '作成時にエラーが発生した場合' do
      let(:endpoint) { 'https://madogiwa0124.hatenablog.com/' }

      it '関連モデルと合わせてfeedが作成されないこと' do
        post_form.create!
      rescue StandardError
        expect(feed).to be_nil
        expect(Entry.count).to be_zero
        expect(FeedTag.count).to be_zero
      end
    end
  end

  describe '#update!', focus: true do
    let(:title) { 'updated_title' }
    let(:params) do
      { id: feed.id, title: title, endpoint: endpoint, tags: tags }
    end
    let(:post_form) { described_class.new(params) }
    let(:feed) { Feed.last }

    before do
      described_class.new(
        title: 'title',
        endpoint: 'https://madogiwa0124.hatenablog.com/rss',
        tags: %w[tag1 tag2]
      ).create!
    end

    context '正常に終了した場合' do
      let(:endpoint) { 'https://madogiwa0124.hatenablog.com/rss' }
      before do
        post_form.update!
        feed.reload
      end

      context 'タグが入力済の場合' do
        let(:tags) { %w[updated_tag] }

        it '関連モデルと合わせてfeedが更新されること' do
          expect(feed.title).to eq title
          expect(feed.endpoint).to eq endpoint
          expect(feed.entries.length).to be_positive
          expect(feed.tags.pluck(:body)).to eq tags
        end
      end

      context 'タグが未入力の場合' do
        let(:tags) { nil }

        it '関連モデルと合わせてfeedが更新されること' do
          expect(feed.title).to eq title
          expect(feed.endpoint).to eq endpoint
          expect(feed.entries.length).to be_positive
          expect(feed.tags).to eq []
        end
      end
    end

    context '作成時にエラーが発生した場合' do
      let(:endpoint) { 'https://madogiwa0124.hatenablog.com/' }

      it '関連モデルと合わせてfeedが更新されないこと' do
        post_form.update!
      rescue StandardError
        expect(feed).to eq feed
        expect(Entry.count).to eq feed.entries.count
        expect(FeedTag.count).to eq feed.tags.count
      end
    end
  end
end
