class Family::Library::LibraryBooksController < Family::ApplicationController
  before_action :set_book

  def show
  end

  def destroy
    @book.destroy!
    redirect_to family_library_path(@family), notice: '本棚から削除しました。', status: :see_other
  end

  private

  def set_book
    @book = @family.family_library.books.find(params[:id])
  end
end
