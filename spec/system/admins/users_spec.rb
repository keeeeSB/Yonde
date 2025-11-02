require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  let(:admin) { create(:admin) }
  let(:family) { create(:family, name: '佐藤') }
  let!(:alice) { create(:user, name: 'アリス', email: 'alice@example.com', confirmed_at: Time.current, family:) }

  before do
    create(:user, name: 'ボブ', email: 'bob@example.com', confirmed_at: Time.current, family:)
  end

  describe 'ユーザー一覧' do
    it '管理者は、ユーザーの一覧を閲覧できる' do
      login_as admin, scope: :admin
      visit admins_users_path

      expect(page).to have_content 'アリス'
      expect(page).to have_content 'alice@example.com'
      expect(page).to have_content '承認済み'

      expect(page).to have_content 'ボブ'
      expect(page).to have_content 'bob@example.com'
      expect(page).to have_content '承認済み'
    end
  end

  describe 'ユーザー詳細' do
    it '管理者は、ユーザーの詳細情報を閲覧できる' do
      login_as admin, scope: :admin
      visit admins_users_path

      expect(page).to have_content 'アリス'
      expect(page).to have_content 'alice@example.com'
      expect(page).to have_content '承認済み'

      first(:link, '詳細').click
      expect(page).to have_current_path admins_user_path(alice)

      expect(page).to have_content 'アリス'
      expect(page).to have_content 'alice@example.com'
      expect(page).to have_content '承認済み'
      expect(page).to have_content '佐藤'
    end
  end

  describe 'ユーザー削除' do
    it '管理者は、ユーザーを削除できる' do
      login_as admin, scope: :admin
      visit admins_users_path

      expect(page).to have_content 'アリス'
      expect(page).to have_content 'alice@example.com'
      expect(page).to have_content '承認済み'

      expect(page).to have_content 'ボブ'
      expect(page).to have_content 'bob@example.com'
      expect(page).to have_content '承認済み'

      expect do
        accept_confirm do
          first(:button, '削除').click
        end
        expect(page).to have_content 'ユーザーを削除しました。'
        expect(page).to have_current_path admins_users_path
      end.to change(User, :count).by(-1)

      expect(page).to have_content 'ボブ'
      expect(page).to have_content 'bob@example.com'
      expect(page).to have_content '承認済み'

      expect(page).not_to have_content 'アリス'
      expect(page).not_to have_content 'alice@example.com'
    end
  end
end
