class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      flash[:notice] = if resource.family.present?
                         'ログインしました。'
                       else
                         'ログインしました。家族情報を登録してください。'
                       end
    end
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.family.present?
      root_path
    else
      new_family_path
    end
  end
end
