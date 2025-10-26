require 'rails_helper'

RSpec.describe '家族招待機能', type: :system do
  let(:family) { create(:family, name: '佐藤') }
  let(:alice) { create(:user, name: 'アリス', family:) }

  before do
    create(:child, name: 'ボブ', family:)
  end

  describe '家族招待' do
    it 'ログイン中のユーザーは、自分の家族を招待できる' do
      login_as alice, scope: :user
      visit profile_path(alice)

      expect(page).to have_content '佐藤家の情報'
      expect(page).to have_content 'ボブ'
      expect(page).not_to have_content 'キャロル'

      click_link '家族を招待する'
      expect(page).to have_current_path new_family_invitation_path(family)

      fill_in 'メールアドレス', with: 'carol@example.com'
      click_button '招待する'

      expect(page).to have_content '招待メールを送信しました。'
      expect(page).to have_current_path complete_family_invitations_path(family)

      email = open_last_email

      expect(email.subject).to eq 'アプリの招待メールが届きました。'
    end

    it '招待を受けたユーザーは新規登録後、招待家族へ参加する' do
      invitation = create(:family_invitation, family:, email: 'carol@example.com', token: 'abc123', accepted_at: nil)

      visit accept_family_invitations_path(token: invitation.token)

      expect(page).to have_content 'ユーザー登録を行なってください。'
      expect(page).to have_current_path new_user_registration_path

      fill_in 'お名前', with: 'キャロル'
      fill_in 'メールアドレス', with: 'carol@example.com'
      fill_in 'パスワード', with: 'password12345', match: :prefer_exact
      fill_in 'パスワード（確認用）', with: 'password12345'

      expect do
        click_button '登録する'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        expect(page).to have_current_path root_path
      end.to change(User, :count).by(1)

      email = open_last_email

      expect(email.subject).to eq 'メールアドレス確認メール'

      click_first_link_in_email(email)

      expect(page).to have_content 'メールアドレスが確認できました。'
      expect(page).to have_current_path new_user_session_path

      fill_in 'メールアドレス', with: 'carol@example.com'
      fill_in 'パスワード', with: 'password12345'
      click_button 'ログインする'

      user = User.last

      expect(page).to have_content 'ログインしました。家族情報も確認してください。'
      expect(page).to have_current_path profile_path(user)
      expect(page).to have_content 'キャロルさんのプロフィール'
      expect(page).to have_content '佐藤家の情報'
    end
  end
end
