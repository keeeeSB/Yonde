class Families::Libraries::LibraryBooks::ReadingLogsController < Families::Libraries::ApplicationController
  def index
    @reading_logs = 
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def reading_log_params
    parmas.expect(reading_log: %i[read_on rating memo])
  end

  def set_reading_log
    @reading_log = @book.reading_logs.find(params[:id])
  end
end
