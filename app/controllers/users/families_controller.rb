class Users::FamiliesController < Users::ApplicationController
  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      current_user.update!(family: @family)
      redirect_to root_path, notice: '家族情報を登録しました。'
    else
      flash.now[:alert] = '家族情報を登録できませんでした。'
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
  end

  private

  def family_params
    params.expect(family: %i[name])
  end
end
