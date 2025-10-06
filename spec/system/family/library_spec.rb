require 'rails_helper'

RSpec.describe '家族本棚機能', type: :system do
  describe '本棚に絵本を追加' do
    let(:family) { create(:family) }
    let(:user) { create(:user, family:) }

    context '検索した絵本が未登録の場合' do
      it 'ログイン中のユーザーは検索した絵本を家族本棚に登録できる' do
        VCR.use_cassette('google_books_search') do
          login_as user, scope: :user
          visit search_books_path

          fill_in '検索', with: 'はらぺこあおむし'
          click_button '検索'

          within(all('.col-md-4.mb-3').find do |col|
            col.has_content?('はらぺこあおむし')
          end) do
            first('.book-card').click
          end

          expect(page).to have_content 'はらぺこあおむし'
          expect(page).to have_button '本棚に追加'

          click_button '本棚に追加'

          expect(page).to have_current_path family_library_path(user.family)
          expect(page).to have_content '絵本を本棚に登録しました。'

          click_link '本棚'
          expect(page).to have_current_path family_library_path(user.family)
          expect(page).to have_content 'はらぺこあおむし'
        end
      end
    end
  end
end
