require 'rails_helper'

RSpec.describe '読み聞かせ記録機能', type: :system do
  let(:family) { create(:family, name: '佐藤') }
  let(:user) { create(:user, name: 'アリス', family:) }
  let(:book) { create(:book, title: 'おしり探偵') }
  let!(:child) { create(:child, name: 'ボブ', family:) }
  let(:family_library) { create(:family_library, family:) }
  let!(:library_book) { create(:library_book, family_library:, book:) }

  describe '読み聞かせ記録の作成' do
    it 'ログイン中のユーザーは絵本を選択し、読み聞かせ記録を作成できる' do
      login_as user, scope: :user
      visit family_library_library_book_path(book)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読み聞かせ記録を作成'

      click_link '読み聞かせ記録を作成'
      expect(page).to have_current_path new_family_library_library_book_reading_log_path(book)
      expect(page).to have_content '読み聞かせ記録作成'

      fill_in '読んだ日', with: '2025-10-10'
      check 'ボブ'
      choose('😄 よかった', allow_label_click: true)
      fill_in 'メモ', with: 'とても楽しそうでした。'
      expect do
        click_button '登録する'
        expect(page).to have_content '読み聞かせ記録を作成しました。'
        expect(page).to have_current_path family_library_library_book_path(book)
      end.to change(ReadingLog, :count).by(1)
    end
  end
end
