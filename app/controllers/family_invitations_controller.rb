class FamilyInvitationsController < ApplicationController
  def accept
    invitation = FamilyInvitation.find_by(token: params[:token])
    return redirect_to root_path, alert: 'この正体は無効またはすでに承認されています。' unless invitation

    if user_signed_in?
      ActiveRecord::Base.transaction do
        current_user.update!(family: invitation.family)
        invitation.update!(accepted_at: Time.current)
      end
      redirect_to profile_path(current_user), notice: '家族情報を登録しました。'
    else
      session[:pending_invitation_token] = invitation.token
      redirect_to new_user_registration_path, notice: 'ユーザー登録を行なってください。'
    end
  end
end
