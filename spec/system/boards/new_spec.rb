require 'rails_helper'

RSpec.describe 'Board作成画面', type: :system, js: true do
  describe '初期表示' do
    before do
      create_list(:feed, 3, :with_entry)
      visit new_board_path
    end

    it '正常に表示されること' do
      within('.navbar') do
        expect(page).to have_content('Dogfeeds')
        expect(page).to have_selector("img[src$='/favicon.ico']")
      end
      within('.boards-new') do
        expect(page).to have_content('Dogfeedsとは')
        expect(page.all('.feed-card').length).to eq 3
      end
    end
  end

  describe 'ボード作成' do
    let!(:feeds) { create_list(:feed, 3, :with_entry) }

    before do
      visit new_board_path
      within('.boards-new') do
        page.find("#feed-card-#{feeds[0].id}").find('.select-feed').click
        page.find("#feed-card-#{feeds[2].id}").find('.select-feed').click
        page.find('.board-create-form input.board-title').fill_in(with: 'board title')
        page.find('.board-create-button button').click
      end
      page.find('.confirm-modal .submit').click
    end

    it 'ボード詳細画面に遷移すること' do
      expect(page).to have_content('board title')
      expect(page).to have_content(feeds[0].title)
      expect(page).to have_content(feeds[2].title)
      expect(page).to have_content('このRSSフィードのURLをコピーする')
    end
  end
end
