require 'rails_helper'

RSpec.describe '家族登録機能', type: :system do
  let!(:user) { create(:user, name: 'アリス') }

  describe '家族登録' do
    it 'ユーザーはユーザー登録、ログイン後、家族登録ページで家族情報を登録できる' do
      login_as user, scope: :user
      visit new_family_path

      fill_in '苗字', with: '佐藤'

      expect do
        click_button '登録する'
        expect(page).to have_content '家族情報を登録しました。'
        expect(page).to have_current_path root_path
      end.to change(Family, :count).by(1)

      click_link 'アリス'
      expect(page).to have_current_path profile_path(user)

      expect(page).to have_content 'アリスさんのプロフィール'
      expect(page).to have_content '佐藤家の情報'
    end
  end
end
