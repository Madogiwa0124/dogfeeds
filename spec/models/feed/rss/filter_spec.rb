require 'rails_helper'

RSpec.describe Feed::Rss::Filter, type: :model do
  describe '.call' do
    context '不正なRSSの場合' do
      let(:resource) { File.read(Rails.root.join('spec/sample/rss_invalid.xml')) }

      it '対象の正規表現を持つ要素が削除されること' do
        result = described_class.call(resource)
        described_class::INVALID_REGEXPS.each do |regexp|
          expect(result).not_to be_match regexp
        end
      end

      it 'RSSオブジェクトにパース出来ること' do
        result = RSS::Parser.parse(described_class.call(resource))
        expect(result.class).to eq RSS::Rss
        expect(result.channel.title).to eq 'invalid rss'
        expect(result.items.length).to eq 1
      end
    end
  end

  context '正常なRSSの場合' do
    let(:resource) { File.read(Rails.root.join('spec/sample/rss.xml')) }

    it '結果が変わらないこと' do
      expect(described_class.call(resource)).to eq resource
    end
  end
end
