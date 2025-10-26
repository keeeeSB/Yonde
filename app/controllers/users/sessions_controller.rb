class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      return unless session[:pending_invitation_token]

      token = session.delete(:pending_invitation_token)
      invitation = FamilyInvitation.find_by(token:)

      if invitation
        ActiveRecord::Base.transaction do
          resource.update!(family: invitation.family)
          invitation.update!(accepted_at: Time.current)
        end
      end

      session[:invitation_processed] = true
    end
  end

  protected

  def after_sign_in_path_for(resource)
    if session[:invitation_processed]
      session.delete(:invitation_processed)
      flash[:notice] = 'ログインしました。家族情報も確認してください。'
      profile_path(resource)
    elsif resource.family.present?
      flash[:notice] = 'ログインしました。'
      root_path
    else
      flash[:notice] = 'ログインしました。家族情報を登録してください。'
      new_family_path
    end
  end
end
