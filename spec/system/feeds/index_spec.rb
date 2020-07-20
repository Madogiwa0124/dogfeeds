require 'rails_helper'

RSpec.describe 'フィード一覧画面', type: :system, js: true do
  describe '初期表示' do
    before do
      create_list(:feed, 3, :with_entry)
      visit feeds_path
    end

    it '正常に表示されること' do
      within('.feed-index') do
        expect(page.all('.feed-card').length).to eq 3
      end
    end
  end

  describe '検索が行えること' do
    before do
      create_list(:feed, 2, :with_entry, title: '検索対象外')
      create(:feed, :with_entry, title: 'フィードのタイトル')
      visit feeds_path
    end

    it '検索結果に合致するフィードだけ表示されること' do
      within('.feed-index') do
        page.find('.search-form input').fill_in(with: 'フィードのタイトル')
        page.find('.search-form .submit').click
        expect(page.all('.feed-card').length).to eq 1
        expect(page.find('.feed-card')).to have_content 'フィードのタイトル'
        expect(page.find('.feed-card')).to_not have_content '検索対象外'
      end
    end
  end
end
