require 'rails_helper'

RSpec.describe '家族情報管理機能', type: :system do
  let(:admin) { create(:admin) }
  let!(:family) { create(:family, name: '佐藤') }

  before do
    create(:family, name: '鈴木')
  end

  describe '家族一覧' do
    it '管理者は、家族の一覧を閲覧できる' do
      login_as admin, scope: :admin
      visit admins_families_path

      expect(page).to have_selector 'h2', text: '家族一覧'
      expect(page).to have_content '佐藤'
      expect(page).to have_content '鈴木'
    end
  end

  describe '家族詳細' do
    before do
      create(:user, name: 'アリス', family:)
      create(:child, name: 'ボブ', family:)
    end

    it '管理者は、家族の詳細を閲覧できる' do
      login_as admin, scope: :admin
      visit admins_families_path

      expect(page).to have_content '佐藤'

      first(:link, '詳細').click
      expect(page).to have_current_path admins_family_path(family)

      expect(page).to have_selector 'h2', text: '家族詳細'
      expect(page).to have_content '家族詳細'
      expect(page).to have_content '佐藤'
      expect(page).to have_content 'アリス'
      expect(page).to have_content 'ボブ'
    end
  end

  describe '家族削除' do
    it '管理者は、家族を削除できる' do
      login_as admin, scope: :admin
      visit admins_families_path

      expect(page).to have_selector 'h2', text: '家族一覧'
      expect(page).to have_content '佐藤'
      expect(page).to have_content '鈴木'

      expect do
        accept_confirm do
          first(:button, '削除').click
        end
        expect(page).to have_content '家族情報を削除しました。'
        expect(page).to have_current_path admins_families_path
      end.to change(Family, :count).by(-1)

      expect(page).to have_content '鈴木'
      expect(page).not_to have_content '佐藤'
    end
  end
end
