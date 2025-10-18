class Families::Libraries::ApplicationController < Families::ApplicationController
  before_action :set_book

  private

  def set_book
    @book = if params[:book_id].present?
              @family.family_library.books.find(params[:book_id])
            else
              @family.family_library.books.find(params[:id])
            end
  end
end
