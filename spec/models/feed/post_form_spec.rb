require 'rails_helper'

RSpec.describe Feed::PostForm, type: :model do
  include RssMockHelper
  let(:valid_rss_body) { File.read(Rails.root.join('spec/sample/rss.xml')) }
  let(:invalid_rss_body) { '<html invald format</html>' }

  describe '#create!' do
    let(:title) { 'sample_title' }
    let(:tags) { %w[tag1 tag2] }
    let(:params) { { title: title, endpoint: 'https://example.com/rss', tags: tags } }

    context '正常に終了した場合' do
      before do
        rss_mock_enable(resource: valid_rss_body)
        described_class.new(params).create!
      end

      it '関連モデルと合わせてfeedが作成されること' do
        feed = Feed.find_by(title: title)
        expect(feed.title).to eq title
        expect(feed.entries.length).to be_positive
        expect(feed.tags.pluck(:body)).to eq tags
      end

      context 'タグが未入力の場合' do
        let(:tags) { nil }

        it '関連モデルと合わせてfeedが作成されること' do
          feed = Feed.find_by(title: title)
          expect(feed.title).to eq title
          expect(feed.entries.length).to be_positive
          expect(feed.tags).to eq []
        end
      end

      context 'タイトルが未入力の場合' do
        let(:tags) { %w[tag1 tag2] }
        let(:title) { '' }

        it 'RSSで取得したタイトルが設定されること' do
          feed = Feed.last
          expect(feed.title).to eq 'Example Rss'
        end
      end
    end

    context '作成時にエラーが発生した場合' do
      before { rss_mock_enable(resource: invalid_rss_body) }

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
    let!(:feed) { create(:feed) }
    let(:params) do
      { id: feed.id, title: title, endpoint: 'https://example.com/rss', tags: tags }
    end

    before { rss_mock_enable(resource: valid_rss_body) }

    context '正常に終了した場合' do
      before do
        described_class.new(params).update!
        feed.reload
      end

      context 'タグが入力済の場合' do
        let(:tags) { %w[updated_tag] }

        it '関連モデルと合わせてfeedが更新されること' do
          expect(feed.title).to eq title
          expect(feed.entries.length).to eq 2
          expect(feed.tags.pluck(:body)).to eq tags
        end
      end

      context 'タグが未入力の場合' do
        let(:tags) { nil }

        it '関連モデルと合わせてfeedが更新されること' do
          expect(feed.title).to eq title
          expect(feed.entries.length).to eq 2
          expect(feed.tags).to eq []
        end
      end
    end

    context '作成時にエラーが発生した場合' do
      before { rss_mock_enable(resource: invalid_rss_body) }

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
