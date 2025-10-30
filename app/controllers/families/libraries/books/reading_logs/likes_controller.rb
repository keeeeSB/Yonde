class Families::Libraries::Books::ReadingLogs::LikesController < Families::Libraries::Books::ApplicationController
  before_action :set_like, only: %i[destroy]

  def create
    @like = current_user.likes.build(reading_log: @reading_log)
    if @like.save
      redirect_back fallback_location: root_path, notice: 'いいねをしました。'
    else
      redirect_back fallback_location: root_path, alert: 'いいねできませんでした。'
    end
  end

  def destroy
    @like.destroy!
    redirect_back fallback_location: root_path, notice: 'いいねを取り消しました。', status: :see_other
  end

  private

  def set_like
    @like = current_user.likes.find_by(reading_log: @reading_log)
  end
end
