class FamilyInvitationsController < ApplicationController
  def accept
    invitation = FamilyInvitation.find_by(token: params[:token])
    return redirect_to root_path, alert: 'この招待は無効またはすでに承認されています。' unless invitation

    session[:pending_invitation_token] = invitation.token
    redirect_to new_user_registration_path, notice: 'ユーザー登録を行なってください。'
  end
end
