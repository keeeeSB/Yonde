require 'rails_helper'

RSpec.describe 'ログイン機能', type: :system do
  let!(:user) { create(:user, name: 'アリス', email: 'alice@example.com', password: 'password12345', confirmed_at: Time.current, family_id: nil) }

  describe 'ユーザーログイン' do
    it 'ユーザーはログインできる' do
      visit root_path
      click_link 'ログイン'
      expect(page).to have_current_path new_user_session_path

      fill_in 'メールアドレス', with: 'alice@example.com'
      fill_in 'パスワード', with: 'password12345'
      click_button 'ログインする'

      expect(page).to have_content 'ログインしました。'
      expect(page).to have_current_path new_family_path(user)
      expect(page).to have_content 'アリス'
    end
  end

  describe 'ユーザーログアウト' do
    before do
      family = create(:family)
      user.update!(family_id: family.id)
    end

    it 'ログイン中のユーザーはログアウトできる' do
      login_as user, scope: :user

      visit root_path
      expect(page).to have_content 'ログアウト'

      click_button 'ログアウト'

      expect(page).to have_content 'ログアウトしました。'
      expect(page).to have_current_path root_path
    end
  end
end
