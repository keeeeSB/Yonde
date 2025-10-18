class Families::ReadingLogsController < Families::ApplicationController
  def index
    @reading_logs = @family.reading_logs.preload(:book, :children).default_order.page(params[:page])
  end
end
