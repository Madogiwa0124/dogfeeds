require 'rails_helper'

RSpec.describe Feed::Rss::Client, type: :model do
  describe '#parsed_items' do
    let(:client) { described_class.new('http://example.com/rss') }

    before { allow(client).to receive(:resource).and_return(resource) }

    context 'rss' do
      let(:resource) { File.read(Rails.root.join('spec/sample/rss.xml')) }

      it 'parseされたentryの一覧が返却されること' do
        expect(client.parsed_items.map(&:class)).to eq [Feed::Rss::ParsedItem, Feed::Rss::ParsedItem]
        expect(client.parsed_items.first.attributes).to eq(
          {
            title: 'title 1',
            description: 'description 1',
            eye_catching_image: 'https://example.com/1.png',
            link: 'https://example.com/1',
            published_at: 'Sat, 04 Jul 2020 21:44:43 +0900'.in_time_zone
          }
        )
      end
    end

    context 'atom' do
      let(:resource) { File.read(Rails.root.join('spec/sample/atom.xml')) }

      it 'parseされたentryの一覧が返却されること' do
        expect(client.parsed_items.map(&:class)).to eq [Feed::Rss::ParsedItem, Feed::Rss::ParsedItem]
        expect(client.parsed_items.first.attributes).to eq(
          {
            title: 'title 1',
            description: 'description 1',
            eye_catching_image: nil,
            link: 'https://example.com/1',
            published_at: '2020-07-21T20:00:00Z'.in_time_zone
          }
        )
      end
    end

    context 'invalid' do
      let(:resource) { '<html invald format</html>' }

      it 'エラーが発生すること' do
        expect { client.parsed_items }.to raise_error RSS::NotWellFormedError
      end
    end
  end
end
