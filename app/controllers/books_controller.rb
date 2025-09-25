class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[search]

  def show
    systemid = params[:id]
    url = "https://www.googleapis.com/books/v1/volumes/#{systemid}"
    response = Faraday.get(url)
    @google_book = JSON.parse(response.body)
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
    params.expect(book: %i[title published_date description isbn image_url])
  end
end
