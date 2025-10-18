require 'rails_helper'

RSpec.describe '読み聞かせ記録機能', type: :system do
  let(:family) { create(:family, name: '佐藤') }
  let(:alice) { create(:user, name: 'アリス', family:) }
  let(:book) { create(:book, title: 'おしり探偵') }
  let!(:child) { create(:child, name: 'ボブ', family:) }
  let(:family_library) { create(:family_library, family:) }
  let!(:library_book) { create(:library_book, family_library:, book:) }

  describe '読み聞かせ記録の作成' do
    it 'ログイン中のユーザーは絵本を選択し、読み聞かせ記録を作成できる' do
      login_as alice, scope: :user
      visit family_library_book_path(book)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読み聞かせ記録を作成'

      click_link '読み聞かせ記録を作成'
      expect(page).to have_current_path new_family_library_book_reading_log_path(book)
      expect(page).to have_content '読み聞かせ記録作成'

      fill_in '読んだ日', with: '2025-10-10'
      check 'ボブ'
      choose('😄 よかった', allow_label_click: true)
      fill_in 'メモ', with: 'とても楽しそうでした。'
      expect do
        click_button '登録する'
        expect(page).to have_content '読み聞かせ記録を作成しました。'
        expect(page).to have_current_path family_library_book_path(book)
      end.to change(ReadingLog, :count).by(1)
    end
  end

  describe '読み聞かせ記録の一覧表示' do
    let(:carol) { create(:user, name: 'キャロル', family:) }
    let!(:reading_log1) { create(:reading_log, rating: 3, user: alice, book:, family:) }
    let!(:reading_log2) { create(:reading_log, rating: 2, user: carol, book:, family:) }

    before do
      create(:child_reading_log, child:, reading_log: reading_log1)
      create(:child_reading_log, child:, reading_log: reading_log2)
    end

    it 'ログイン中のrootページに、家族の読み聞かせ記録が一覧表示される' do
      login_as alice, scope: :user
      visit root_path

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： アリス'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_content 'よかった'

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： キャロル'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_content 'ふつう'
    end
  end

  describe '読み聞かせ記録の編集' do
    let!(:reading_log) { create(:reading_log, user: alice, book:, family:, rating: 2, read_on: '2025-10-10') }

    before do
      create(:child_reading_log, child:, reading_log:)
    end

    it 'ログイン中のユーザーは、自身が作成した読み聞かせ記録を編集できる' do
      login_as alice, scope: :user
      visit root_path

      expect(page).to have_content '佐藤家の読み聞かせ記録'
      expect(page).to have_content '読んだ日： 10月10日'
      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： アリス'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_content '😐 ふつう'

      click_link '編集'
      expect(page).to have_current_path edit_family_library_book_reading_log_path(book, reading_log)

      fill_in '読んだ日', with: '2025-10-12'
      choose('😞 よくなかった', allow_label_click: true)
      fill_in 'メモ', with: '反応がイマイチでした。'
      click_button '更新する'

      expect(page).to have_content '読み聞かせ記録を更新しました。'
      expect(page).to have_current_path family_library_book_path(book)
      expect(page).to have_content '読んだ日： 10月12日'
      expect(page).to have_content '😞 よくなかった'
      expect(page).to have_content '反応がイマイチでした。'
    end
  end

  describe '読み聞かせ記録の削除' do
    let!(:reading_log) { create(:reading_log, user: alice, book:, family:, rating: 2, read_on: '2025-10-10') }

    before do
      create(:child_reading_log, child:, reading_log:)
    end

    it 'ログイン中のユーザーは、自身が作成した読み聞かせ記録を削除できる' do
      login_as alice, scope: :user
      visit root_path

      expect(page).to have_content '佐藤家の読み聞かせ記録'
      expect(page).to have_content '読んだ日： 10月10日'
      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： アリス'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_content '😐 ふつう'

      expect do
        accept_confirm do
          click_button '削除'
        end
        expect(page).to have_content '読み聞かせ記録を削除しました。'
      end.to change(ReadingLog, :count).by(-1)
    end
  end
end
