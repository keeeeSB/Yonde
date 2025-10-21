class Families::Libraries::Books::ReadingLogs::CommentsController < Families::Libraries::Books::ApplicationController
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = @reading_log.comments.build(comment_params)
    if @comment.save
      redirect_to family_library_book_reading_log_path(@book, @reading_log), notice: 'コメントを投稿しました。'
    else
      puts @comment.errors.full_messages
      redirect_to family_library_book_reading_log_path(@book, @reading_log), alert: 'コメントを投稿できませんでした。'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to family_library_book_reading_log_path(@book, @reading_log), notice: 'コメントを更新しました。'
    else
      redirect_to family_library_book_reading_log_path(@book, @reading_log), alert: 'コメントを更新できませんでした。'
    end
  end

  def destroy
    @comment.destroy!
    redirect_to family_library_book_reading_log_path(@book, @reading_log), notice: 'コメントを削除しました。', status: :see_other
  end

  private

  def set_comment
    @comment = @reading_log.comments.find(params[:id])
  end

  def comment_params
    params.expect(comment: %i[body]).merge(user: current_user)
  end
end
