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

  describe 'フィード検索' do
    context 'タグをクリックした場合' do
      before do
        create_list(:feed, 2, :with_entry, :with_tag, title: 'test_1 feed', tag_body: 'test_1')
        create(:feed, :with_entry, :with_tag, title: 'test_2 feed', tag_body: 'test_2')
        create(:feed, :with_entry, title: 'untagged feed')
        visit feeds_path
        within('.search-form .tag-area') { page.first('.my-tag').click }
      end

      it '検索結果に合致するフィードだけ表示されること' do
        within('.feed-index') do
          expect(page.find('.feed-card-collection')).to_not have_content 'test_2 feed'
          expect(page.find('.feed-card-collection')).to_not have_content 'untagged feed'
          expect(page.find('.feed-card-collection')).to have_content 'test_1 feed'
          expect(page.all('.feed-card-collection .feed-card').length).to eq 2
        end
      end
    end

    context 'キーワードを入力して検索ボタンを押下した場合' do
      before do
        create_list(:feed, 2, :with_entry, title: '検索対象外')
        create(:feed, :with_entry, title: 'Searched')
        visit feeds_path
        page.find('.search-form .control input').fill_in(with: 'Searched')
        click_button('検索')
      end

      it '検索結果に合致するフィードだけ表示されること' do
        within('.feed-index') do
          expect(page.find('.feed-card-collection')).to_not have_content '検索対象外'
          expect(page.find('.feed-card-collection')).to have_content 'Searched'
          expect(page.all('.feed-card-collection .feed-card').length).to eq 1
        end
      end
    end
  end
end
