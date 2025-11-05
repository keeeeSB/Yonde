require 'rails_helper'

RSpec.describe '読み聞かせ記録管理機能', type: :system do
  let(:admin) { create(:admin) }
  let(:family) { create(:family, name: '佐藤') }
  let(:alice) { create(:user, name: 'アリス', family:) }
  let(:carol) { create(:user, name: 'キャロル', family:) }
  let(:family_library) { create(:family_library, family:) }
  let!(:child) { create(:child, name: 'ボブ', family:) }
  let!(:book1) { create(:book, title: 'おしり探偵') }
  let!(:book2) { create(:book, title: 'はらぺこあおむし', systemid: 'abcdefg23456') }
  let!(:reading_log) { create(:reading_log, read_on: '2025-10-10', family:, user: alice, book: book1) }

  before do
    create(:child_reading_log, reading_log:, child:)
    create(:reading_log, read_on: '2025-10-15', family:, user: carol, book: book2)
  end

  describe '読み聞かせ記録一覧' do
    it '管理者は、読み聞かせ記録の一覧を閲覧できる' do
      login_as admin, scope: :admin
      visit admins_family_path(family)

      expect(page).to have_selector 'h2', text: '家族詳細'
      expect(page).to have_content '佐藤'
      expect(page).to have_content 'アリス'
      within 'tr', text: '読み聞かせ記録の数' do
        expect(page).to have_content '2'
        expect(page).to have_link '読み聞かせ記録一覧へ'
      end

      click_link '読み聞かせ記録一覧へ'
      expect(page).to have_current_path admins_family_reading_logs_path(family)

      expect(page).to have_selector 'h2', text: '佐藤家の読み聞かせ記録一覧'
      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '2025年10月10日'
      expect(page).to have_content 'アリス'

      expect(page).to have_content 'はらぺこあおむし'
      expect(page).to have_content '2025年10月15日'
      expect(page).to have_content 'キャロル'
    end
  end

  describe '読み聞かせ記録詳細' do
    it '管理者は、読み聞かせ記録の詳細を閲覧できる' do
      login_as admin, scope: :admin
      visit admins_family_reading_logs_path(family)

      expect(page).to have_selector 'h2', text: '佐藤家の読み聞かせ記録一覧'
      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '2025年10月10日'
      expect(page).to have_content 'アリス'

      expect(page).to have_content 'はらぺこあおむし'
      expect(page).to have_content '2025年10月15日'
      expect(page).to have_content 'キャロル'

      first(:link, '詳細').click
      expect(page).to have_current_path admins_family_reading_log_path(family, reading_log)

      expect(page).to have_selector 'h2', text: '読み聞かせ記録詳細'
      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '2025年10月10日'
      expect(page).to have_content 'アリス'
      expect(page).to have_content 'ボブ'
    end
  end

  describe '読み聞かせ記録削除' do
    it '管理者は、読み聞かせ記録を削除できる' do
      login_as admin, scope: :admin
      visit admins_family_reading_logs_path(family)

      expect(page).to have_selector 'h2', text: '佐藤家の読み聞かせ記録一覧'
      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '2025年10月10日'
      expect(page).to have_content 'アリス'

      expect(page).to have_content 'はらぺこあおむし'
      expect(page).to have_content '2025年10月15日'
      expect(page).to have_content 'キャロル'

      expect do
        accept_confirm do
          first(:button, '削除').click
        end
        expect(page).to have_content '読み聞かせ記録を削除しました。'
        expect(page).to have_current_path admins_family_reading_logs_path(family)
      end.to change(family.reading_logs, :count).by(-1)

      expect(page).to have_content 'はらぺこあおむし'
      expect(page).to have_content '2025年10月15日'
      expect(page).to have_content 'キャロル'

      expect(page).not_to have_content 'おしり探偵'
      expect(page).not_to have_content '2025年10月10日'
      expect(page).not_to have_content 'アリス'
    end
  end
end
