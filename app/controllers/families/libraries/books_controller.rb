class Families::Libraries::BooksController < Families::Libraries::ApplicationController
  def show
  end

  def destroy
    @book.destroy!
    redirect_to family_library_path(@family), notice: '本棚から削除しました。', status: :see_other
  end
end
