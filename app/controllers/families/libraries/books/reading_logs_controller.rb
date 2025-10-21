class Families::Libraries::Books::ReadingLogsController < Families::Libraries::Books::ApplicationController
  def show
  end

  def new
    @reading_log = @book.reading_logs.build
  end

  def edit
  end

  def create
    @reading_log = @book.reading_logs.build(reading_log_params)

    if @reading_log.save
      redirect_to family_library_book_path(@book), notice: '読み聞かせ記録を作成しました。'
    else
      flash.now[:alert] = '読み聞かせ記録を作成できませんでした。'
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @reading_log.update(reading_log_params)
      redirect_to family_library_book_path(@book), notice: '読み聞かせ記録を更新しました。'
    else
      flash.now[:alert] = '読み聞かせ記録を更新できませんでした。'
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @reading_log.destroy!
    redirect_to family_library_book_path(@book), notice: '読み聞かせ記録を削除しました。', status: :see_other
  end

  private

  def reading_log_params
    params.expect(reading_log: [:read_on, :rating, :memo, { child_ids: [] }]).merge(user_id: current_user.id, family_id: @family.id)
  end
end
