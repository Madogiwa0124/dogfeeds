require 'rails_helper'

RSpec.describe 'フィード作成画面', type: :system, js: true do
  describe '初期表示' do
    before { visit new_feed_path }

    it '正常に表示されること' do
      within('.feed-form') do
        expect(page).to have_content 'タイトル'
        expect(page).to have_content 'Url'
        expect(page).to have_content 'タグ'
      end
    end
  end

  describe 'フィード作成' do
    include RssMockHelper

    before do
      valid_body = File.read(Rails.root.join('spec/sample/rss.xml'))
      rss_mock_enable(resource: valid_body)
      visit new_feed_path
    end

    it '入力値でフィードが作成されること' do
      within('.feed-form') do
        page.find('#feed_title').fill_in(with: 'feed title')
        page.find('#feed_endpoint').fill_in(with: 'https://example.com/rss')
        click_button '登録する'
      end

      expect(page).to have_content('feed title')
    end
  end
end
