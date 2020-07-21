require 'rails_helper'

RSpec.describe 'Board一覧画面', type: :system do
  describe '初期表示' do
    before do
      create_list(:board, 3, :with_feeds)
      visit boards_path
    end

    it '正常に表示されること' do
      within('.board-index') do
        expect(page.all('.board-card').length).to eq 3
      end
    end
  end
end
