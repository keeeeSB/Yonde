class Admins::Families::ApplicationController < Admins::ApplicationController
  before_action :set_family

  private

  def set_family
    @family = Family.find(params[:family_id])
  end
end
