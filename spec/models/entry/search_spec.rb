require 'rails_helper'

RSpec.describe Entry::Search, type: :model do
  describe '.call' do
    let!(:feed) { create(:feed) }
    let!(:entries) { create_list(:entry, 3, feed: feed) }

    context '条件を指定した場合' do
      it '絞り込まれた記事の一覧が取得されること' do
        result = Entry::Search.call(params: { ids: [entries[0].id, entries[2].id] })
        expect(result).to eq [entries[2], entries[0]]
      end
    end

    context '条件を指定しなかった場合' do
      it '記事が全件取得されること' do
        result = Entry::Search.call(params: {})
        expect(result).to eq [entries[2], entries[1], entries[0]]
      end
    end
  end
end
