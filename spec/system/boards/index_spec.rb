require 'rails_helper'

RSpec.describe 'Board一覧画面', type: :system, js: true do
  describe '初期表示' do
    context 'ボードが存在する場合' do
      before do
        boards = create_list(:board, 2, :with_feeds)
        create(:entry, feed: boards[0].feeds.take)
        create(:entry, feed: boards[1].feeds.take)
        visit boards_path
      end

      it '正常に表示されること' do
        within('.board-index') do
          expect(page.all('.board-card').length).to eq 2
        end
      end
    end

    context 'ボードが存在しない場合' do
      before { visit boards_path }

      it 'メッセージが表示されること' do
        within('.board-index') do
          expect(page).to have_content '登録されているボードがありません'
        end
      end
    end
  end
end
