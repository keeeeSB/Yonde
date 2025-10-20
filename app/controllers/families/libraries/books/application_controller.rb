class Families::Libraries::Books::ApplicationController < Families::Libraries::ApplicationController
  before_action :set_reading_log

  private
  def set_reading_log
    @reading_log = if params[:reading_log_id].present?
                     @book.reading_logs.find(params[:reading_log_id])
                   else
                     @book.reading_logs.find(params[:id])
                   end
  end
end
