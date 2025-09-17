class Users::FamiliesController < Users::ApplicationController
  before_action :set_family, only: %i[edit update]

  def new
    if current_user.family.present?
      redirect_to root_path, notice: '既に家族情報を登録しています。'
    end

    @family = Family.new
    @family.children.build
  end

  def edit
    @family.children.build
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      current_user.update!(family: @family)
      redirect_to profile_path(current_user), notice: '家族情報を登録しました。'
    else
      flash.now[:alert] = '家族情報を登録できませんでした。'
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @family.update(family_params)
      redirect_to profile_path(current_user), notice: '家族情報を更新しました。'
    else
      flash.now[:alert] = '家族情報を更新できませんでした。'
      render :edit, status: :unprocessable_content
    end
  end

  private

  def family_params
    params.expect(family: [:name, children_attributes: %i[id name birthday gender]])
  end

  def set_family
    @family = current_user.family
  end
end
