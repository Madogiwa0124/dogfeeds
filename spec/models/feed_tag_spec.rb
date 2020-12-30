require 'rails_helper'

RSpec.describe FeedTag, type: :model do
  describe 'counted_tags' do
    before do
      create(:feed_tag, body: 'test_0')
      create(:feed, :with_entry, :with_tag, tag_body: 'test1')
      create(:feed, :with_entry, :with_tag, tag_body: 'test1')
      create(:feed, :with_entry, :with_tag, tag_body: 'test1')
      create(:feed, :with_entry, :with_tag, tag_body: 'test2')
      create(:feed, :with_entry, :with_tag, tag_body: 'test2')
      create(:feed, :with_entry, :with_tag, tag_body: 'test3')
    end

    it '指定した件数分、feedに設定されたタグと件数のhashが取得出来ること' do
      expect(FeedTag.counted_tags(limit: 2)).to eq [
        { body: 'test1', count: 3 }, { body: 'test2', count: 2 }
      ]
    end
  end
end
