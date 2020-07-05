require 'rails_helper'

RSpec.describe Feed::PostForm, type: :model do
  include RssMockHelper

  before do
    valid_body = File.read(Rails.root.join('spec/sample/rss.xml'))
    rss_mock_enable(endpoint: 'https://example.com/rss', body: valid_body)
    invald_body = '<html invald format</html>'
    rss_mock_enable(endpoint: 'https://example.com/', body: invald_body)
  end

  describe '#create!' do
    let(:title) { 'title' }
    let(:params) { { title: title, endpoint: endpoint, tags: tags } }

    context '正常に終了した場合' do
      let(:endpoint) { 'https://example.com/rss' }
      before { described_class.new(params).create! }

      context 'タグが入力済みの場合' do
        let(:tags) { %w[tag1 tag2] }

        it '関連モデルと合わせてfeedが作成されること' do
          feed = Feed.find_by(title: title)
          expect(feed.title).to eq title
          expect(feed.endpoint).to eq endpoint
          expect(feed.entries.length).to be_positive
          expect(feed.tags.pluck(:body)).to eq tags
        end
      end

      context 'タグが未入力の場合' do
        let(:tags) { nil }

        it '関連モデルと合わせてfeedが作成されること' do
          feed = Feed.find_by(title: title)
          expect(feed.title).to eq title
          expect(feed.endpoint).to eq endpoint
          expect(feed.entries.length).to be_positive
          expect(feed.tags).to eq []
        end
      end
    end

    context '作成時にエラーが発生した場合' do
      let(:endpoint) { 'https://example.com/' }

      it '関連モデルと合わせてfeedが作成されないこと' do
        described_class.new(params).create!
      rescue StandardError
        feed = Feed.find_by(title: title)
        expect(feed).to be_nil
        expect(Entry.count).to be_zero
        expect(FeedTag.count).to be_zero
      end
    end
  end

  describe '#update!', focus: true do
    let(:title) { 'updated_title' }
    let(:feed) { Feed.last }
    let(:params) do
      { id: feed.id, title: title, endpoint: endpoint, tags: tags }
    end

    before do
      described_class.new(
        title: 'title',
        endpoint: 'https://example.com/rss',
        tags: %w[tag1 tag2]
      ).create!
    end

    context '正常に終了した場合' do
      let(:endpoint) { 'https://example.com/rss' }
      before do
        described_class.new(params).update!
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
      let(:endpoint) { 'https://example.com/' }

      it '関連モデルと合わせてfeedが更新されないこと' do
        described_class.new(params).update!
      rescue StandardError
        expect(feed).to eq feed
        expect(Entry.count).to eq feed.entries.count
        expect(FeedTag.count).to eq feed.tags.count
      end
    end
  end
end
