# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'マイページ', type: :system, js: true do
  describe '初期表示' do
    let!(:feed) { create(:feed) }

    before do
      create(:entry, feed: feed, title: 'sample entry')
      visit new_board_path
      page.find('.feed-card .entry-info .entry-clip').click
      visit mypage_path
    end

    it '正常に表示されること' do
      within '.profile' do
        expect(page).to have_css '.avatar'
        expect(page).to have_content 'MY PAGE'
      end
      within 'main' do
        expect(page.find('.tabs .is-active')).to have_content 'CLIP'
        expect(page.all('.content .entry-card').length).to eq 1
        expect(page.find('.content .entry-card')).to have_content 'sample entry'
      end
    end
  end
  describe 'CLIP' do
    let!(:feed) { create(:feed, :with_entry) }

    context 'CLIPを解除してリロードした場合' do
      before do
        visit new_board_path
        page.find('.feed-card .entry-info .entry-clip').click
        visit mypage_path
        within('main') { page.find('.content .entry-card .entry-clip').click }
        visit mypage_path
      end

      it 'CLIP記事が表示されないこと' do
        within 'main' do
          expect(page.find('.tabs .is-active')).to have_content 'CLIP'
          expect(page.all('.content .entry-card').length).to eq 0
        end
      end
    end
  end
end
