require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let(:family) { create(:family, name: '佐藤') }
  let(:alice) { create(:user, name: 'アリス', family:) }
  let(:carol) { create(:user, name: 'キャロル', family:) }
  let(:child) { create(:child, name: 'ボブ', family:) }
  let!(:book) { create(:book, title: 'おしり探偵') }
  let!(:reading_log) { create(:reading_log, book:, user: alice) }
  let!(:family_library) { create(:family_library, family:) }

  before do
    create(:library_book, family_library:, book:)
    create(:child_reading_log, reading_log:, child:)
  end

  describe 'コメント投稿' do
    it 'ログイン中のユーザーは読み聞かせ記録にコメントができる' do
      login_as carol, scope: :user
      visit family_library_book_reading_log_path(book, reading_log)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： アリス'
      expect(page).to have_content '読み聞かせた子： ボブ'

      click_button 'コメントする'

      fill_in 'コメント', with: '楽しそうですね！'
      expect do
        click_button '投稿する'
        expect(page).to have_content 'コメントを投稿しました。'
        expect(page).to have_current_path family_library_book_reading_log_path(book, reading_log)
      end.to change(reading_log.comments, :count).by(1)

      within('[data-test-class="comment-card"]') do
        expect(page).to have_content 'キャロル'
        expect(page).to have_content '楽しそうですね！'
      end
    end
  end

  describe 'コメント編集' do
    let!(:comment) { create(:comment, reading_log:, user: carol, body: '楽しそうですね！') }

    it 'ログイン中のユーザーは、自身の投稿したコメントを編集できる' do
      login_as carol, scope: :user
      visit family_library_book_reading_log_path(book, reading_log)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： アリス'
      expect(page).to have_content '読み聞かせた子： ボブ'

      within('[data-test-class="comment-card"]') do
        expect(page).to have_content 'キャロル'
        expect(page).to have_content '楽しそうですね！'
        click_button '編集'
      end

      fill_in 'コメント', with: '自分も読んでみます。'
      click_button '投稿する'

      expect(page).to have_content 'コメントを更新しました。'
      expect(page).to have_current_path family_library_book_reading_log_path(book, reading_log)

      within('[data-test-class="comment-card"]') do
        expect(page).to have_content 'キャロル'
        expect(page).to have_content '自分も読んでみます。'
      end
    end
  end

  describe 'コメント削除' do
    let!(:comment) { create(:comment, reading_log:, user: carol, body: '楽しそうですね！') }

    it 'ログイン中のユーザーは、自身が投稿したコメントを削除できる' do
      login_as carol, scope: :user
      visit family_library_book_reading_log_path(book, reading_log)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ人： アリス'
      expect(page).to have_content '読み聞かせた子： ボブ'

      expect(page).to have_content 'キャロル'
      expect(page).to have_content '楽しそうですね！'
      expect do
        accept_confirm do
          click_button '削除'
        end
        expect(page).to have_content 'コメントを削除しました。'
        expect(page).to have_current_path family_library_book_reading_log_path(book, reading_log)
      end.to change(reading_log.comments, :count).by(-1)

      expect(page).not_to have_content '楽しそうですね！'
      expect(page).to have_content 'コメントがありません。'
    end
  end
end
