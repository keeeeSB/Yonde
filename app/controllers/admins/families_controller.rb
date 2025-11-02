class Admins::FamiliesController < Admins::ApplicationController
  before_action :set_family, only: %i[show destroy]

  def index
    @families = Family.default_order.page(params[:page])
  end

  def show
  end

  def destroy
    @family.destroy!
    redirect_to admins_families_path, notice: '家族情報を削除しました。', status: :see_other
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end
end
