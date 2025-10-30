require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  let(:family) { create(:family) }
  let(:alice) { create(:user, name: 'アリス', family:) }
  let(:carol) { create(:user, name: 'キャロル', family:) }
  let(:child) { create(:child, name: 'ボブ', family:) }
  let!(:book) { create(:book, title: 'おしり探偵') }
  let!(:reading_log) { create(:reading_log, book:, user: carol, read_on: '2025-10-01') }
  let!(:family_library) { create(:family_library, family:) }

  before do
    create(:library_book, family_library:, book:)
    create(:child_reading_log, reading_log:, child:)
  end

  describe 'いいね' do
    it 'ログイン中のユーザーは、読み聞かせ記録にいいねができる' do
      login_as alice, scope: :user
      visit family_library_book_reading_log_path(book, reading_log)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ日： 10月1日'
      expect(page).to have_content '読んだ人： キャロル'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_selector '.btn.btn-outline-primary', text: 'いいね👍'

      expect do
        click_button 'いいね👍'
        expect(page).to have_content 'いいねをしました。'
      end.to change(reading_log.likes, :count).by(1)

      expect(page).to have_content '読んだ日： 10月1日'
      expect(page).to have_content '読んだ人： キャロル'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_selector '.btn.btn-primary', text: 'いいね👍'
    end

    it 'ログイン中のユーザーは、自身がしたいいねを取り消すことができる' do
      create(:like, reading_log:, user: alice)
      login_as alice, scope: :user
      visit family_library_book_reading_log_path(book, reading_log)

      expect(page).to have_content 'おしり探偵'
      expect(page).to have_content '読んだ日： 10月1日'
      expect(page).to have_content '読んだ人： キャロル'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_selector '.btn.btn-primary', text: 'いいね👍'

      expect do
        click_button 'いいね👍'
        expect(page).to have_content 'いいねを取り消しました。'
      end.to change(reading_log.likes, :count).by(-1)

      expect(page).to have_content '読んだ日： 10月1日'
      expect(page).to have_content '読んだ人： キャロル'
      expect(page).to have_content '読み聞かせた子： ボブ'
      expect(page).to have_selector '.btn.btn-outline-primary', text: 'いいね👍'
    end
  end
end
