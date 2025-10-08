class Families::Libraries::ApplicationController < Families::ApplicationController
  before_action :set_book

  private

  def set_book
    @book = @family.family_library.books.find(params[:id])
  end
end