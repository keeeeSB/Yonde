require 'rails_helper'

RSpec.describe '管理者ログイン', type: :system do
  it '管理者は管理画面にログインできる' do
    create(:admin, email: 'alice@example.com', password: 'password12345')

    visit new_admin_session_path

    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password12345'
    click_button 'ログイン'

    expect(page).to have_content 'ログインしました。'
    expect(page).to have_current_path admins_root_path
  end
end
