require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books/search' do
    let(:user) { create(:user) }

    it 'Google Books APIsの検索結果が表示される' do
      login_as user, scope: :user

      stub_request(:get, 'https://www.googleapis.com/books/v1/volumes')
        .with(query: hash_including({ 'q' => 'Ruby', 'langRestrict' => 'ja' }))
        .to_return(
          status: 200,
          body: {
            items: [
              {
                'id' => 'abc123',
                volumeInfo: {
                  title: 'たのしいRuby',
                  authors: ['青木 峰郎', '高橋 征義'],
                  publishedDate: '2019',
                },
              },
            ],
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      get search_books_path, params: { search: 'Ruby' }

      expect(response).to have_http_status(:success)
      expect(response.body).to include('たのしいRuby')
      expect(response.body).to include('青木 峰郎')
    end
  end
end
