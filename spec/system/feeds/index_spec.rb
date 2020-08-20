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

    it 'RSSフィード一覧のタグが選択されていること' do
      within('.feed-index .tabs') do
        expect(page).to have_css('.feeds.is-active')
      end
    end

    context '記事一覧のタブをクリックした場合' do
      before { page.find('.feed-index .tabs .entries').click }

      it 'エントリー単位で記事の一覧が表示されること' do
        within('.feed-index') do
          expect(page.all('.entry-card').length).to eq 3
        end
      end
    end
  end

  describe '検索が行えること' do
    before do
      create_list(:feed, 2, :with_entry, title: '検索対象外')
      create(:feed, :with_entry, title: 'Searched')
      visit feeds_path
    end

    it '検索結果に合致するフィードだけ表示されること' do
      within('.feed-index') do
        page.find('.search-form .control input').fill_in(with: 'Searched')
        click_button('検索')
        expect(page.find('.feed-card-collection')).to_not have_content '検索対象外'
        expect(page.find('.feed-card-collection')).to have_content 'Searched'
        expect(page.all('.feed-card-collection .feed-card').length).to eq 1
      end
    end
  end
end
