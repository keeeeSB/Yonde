class Admins::Families::ReadingLogsController < Admins::Families::ApplicationController
  before_action :set_reading_log, only: %i[show destroy]

  def index
    @reading_logs = @family.reading_logs.order(id: :asc).page(params[:page])
  end

  def show
  end

  def destroy
    @reading_log.destroy!
    redirect_to admins_family_reading_logs_path(@family), notice: '読み聞かせ記録を削除しました。', status: :see_other
  end

  private

  def set_reading_log
    @reading_log = @family.reading_logs.find(params[:id])
  end
end
