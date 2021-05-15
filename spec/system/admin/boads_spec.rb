require 'rails_helper'

RSpec.describe 'Admin Board一覧画面', type: :system, js: true do
  describe '一覧画面' do
    before do
      boards = [create(:board, :with_feeds, title: 'board1'), create(:board, :with_feeds, title: 'board2')]
      create(:entry, feed: boards[0].feeds.take)
      create(:entry, feed: boards[1].feeds.take)
      visit_with_basic_login admin_boards_path
    end

    it '正常に表示されること' do
      within('.boads-collection') do
        expect(page.all('.board').length).to eq 2
        expect(page).to have_content 'board1'
        expect(page).to have_content 'board2'
      end
    end
  end

  describe '詳細画面' do
    before do
      feeds = [create(:feed, :with_entry, title: 'feed title1'), create(:feed, :with_entry, title: 'feed title2')]
      board = create(:board, title: 'boad title', feeds: feeds)
      visit_with_basic_login admin_board_path(board)
    end

    it '正常に表示されること' do
      within('.title') { expect(page).to have_content 'boad title' }
      within('.feed-collection tbody') do
        expect(page.all('tr').length).to eq 2
        expect(page).to have_content 'feed title1'
        expect(page).to have_content 'feed title2'
      end
    end
  end

  describe '編集画面' do
    before do
      feeds = [create(:feed, :with_entry, title: 'feed title1'), create(:feed, :with_entry, title: 'feed title2')]
      board = create(:board, title: 'boad title', feeds: feeds)
      visit_with_basic_login edit_admin_board_path(board)

      within('form') do
        find('input[name="board[title]"]').set 'updated'
        find("select option[value='#{feeds[1].id}'").click # NOTE: feed2の選択を外す
        click_button '更新する'
      end
    end

    it '正常に更新できること' do
      within('.title') { expect(page).to have_content 'updated' }
      within('.feed-collection tbody') do
        expect(page.all('tr').length).to eq 1
        expect(page).to have_content 'feed title1'
      end
    end
  end
end
