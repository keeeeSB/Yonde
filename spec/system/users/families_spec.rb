require 'rails_helper'

RSpec.describe '家族登録機能', type: :system do
  let!(:user) { create(:user, name: 'アリス', email: 'alice@example.com', password: 'password12345') }

  describe '家族登録' do
    it 'ユーザーはユーザー登録、ログイン後、家族登録ページにリダイレクトされ家族情報を登録できる' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'alice@example.com'
      fill_in 'パスワード', with: 'password12345'
      click_button 'ログインする'

      expect(page).to have_content 'ログインしました。家族情報を登録してください。'
      expect(page).to have_current_path new_family_path(user)

      fill_in '苗字', with: '佐藤'
      fill_in 'お子様のお名前', with: 'いちろう'
      fill_in '誕生日', with: '2022-01-01'
      select '男の子', from: '性別'

      expect do
        click_button '登録する'
        expect(page).to have_content '家族情報を登録しました。'
        expect(page).to have_current_path profile_path(user)
      end.to change(Family, :count).by(1)
                                   .and change(Child, :count).by(1)

      expect(page).to have_content '佐藤家の情報'
      expect(page).to have_content 'いちろう'
      expect(page).to have_content '男の子'
    end
  end

  describe '家族編集' do
    it 'ユーザーは家族情報を編集できる' do
      family = create(:family, name: '佐藤')
      user.update!(family:)

      login_as user, scope: :user
      visit profile_path(user)

      expect(page).to have_content 'アリスさんのプロフィール'
      expect(page).to have_content '佐藤家の情報'

      within("[data-test='family-card']") do
        click_link '編集'
      end

      expect(page).to have_current_path edit_family_path(user, family)
      expect(page).to have_content '家族情報編集'

      all('.nested-fields').last.tap do |fields|
        within(fields) do
          fill_in 'お子様のお名前', with: 'あいこ'
          fill_in '誕生日', with: '2023-01-01'
          select '女の子', from: '性別'
        end
      end

      expect do
        click_button '更新する'
        expect(page).to have_content '家族情報を更新しました。'
        expect(page).to have_current_path profile_path(user)
      end.to change(Child, :count).by(1)

      expect(page).to have_content '佐藤家の情報'
      expect(page).to have_content 'あいこ'
      expect(page).to have_content '女の子'
    end
  end
end
