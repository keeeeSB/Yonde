class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[search]

  def show
    systemid = params[:id]
    url = "https://www.googleapis.com/books/v1/volumes/#{systemid}"
    response = Faraday.get(url)
    @google_book = JSON.parse(response.body)
  end

  def create
    ActiveRecord::Base.transaction do
      @book = Book.create!(book_params)
      params[:book][:authors].each do |author_name|
        author = Author.find_or_create_by!(name: author_name)
        Authorship.create!(book: @book, author: author)
      end
      family_library = current_user.family.family_library || current_user.family.create_family_library!
      family_library.library_books.create!(book: @book)
    end
    redirect_to family_library_path(current_user.family), notice: '絵本を本棚に登録しました。'
  end

  def search
    if params[:search].nil?
      nil
    elsif params[:search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      nil
    else
      url = 'https://www.googleapis.com/books/v1/volumes'
      text = params[:search]
      res = Faraday.get(url, q: text, langRestrict: 'ja', maxResults: 30)
      @google_books = JSON.parse(res.body)
    end
  end

  def book_params
    params.expect(book: %i[title published_date description systemid page_count image_url])
  end
end
