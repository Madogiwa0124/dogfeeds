require 'rails_helper'

RSpec.describe 'Board詳細画面', type: :system, js: true do
  describe '初期表示' do
    let!(:board) { create(:board, title: 'board title') }

    before do
      create(:board_feed, board: board,  feed: create(:feed, :with_entry, title: 'feed 1'))
      create(:board_feed, board: board,  feed: create(:feed, :with_entry, title: 'feed 2'))
      visit board_path(board)
    end

    it '正常に表示されること' do
      expect(page).to have_content 'board title'
      expect(page).to have_content 'このRSSフィードのURLをコピーする'
      within('.description') do
        expect(page).to have_content '「feed 1、feed 2」をまとめたRSSフィードです。'
      end
      within('.entry-card-collection') do
        expect(page.all('.entry-card').length).to eq 2
      end
    end
  end

  describe 'RSS' do
    let!(:board) { create(:board, title: 'board title') }

    before do
      create(:board_feed, board: board,  feed: create(:feed, :with_entry, title: 'feed 1'))
      create(:board_feed, board: board,  feed: create(:feed, :with_entry, title: 'feed 2'))
      visit board_path(board, format: :rss)
    end

    it '正常に表示されること' do
      xml = Capybara.string(page.body)
      expect(xml).to have_content '<?xml version="1.0" encoding="UTF-8"?>'
      expect(xml).to have_content 'board title'
      expect(xml).to have_content '「feed 1、feed 2」をまとめたRSSフィードです。'
    end
  end
end
