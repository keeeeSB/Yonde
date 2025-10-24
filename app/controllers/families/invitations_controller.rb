class Families::InvitationsController < Families::ApplicationController
  def new
    @invitation = @family.family_invitations.build
  end

  def create
    @invitation = @family.family_invitations.build(invitation_params)
    if @invitation.save
      InvitationMailer.family_invitation(@invitation, current_user).deliver_now
      redirect_to complete_family_invitations_path(@family), notice: '招待メールを送信しました。'
    else
      flash.now[:alert] = '招待メールを送信できませんでした。'
      render :new, status: :unprocessable_content
    end
  end

  def complete
  end

  private

  def invitation_params
    params.expect(family_invitation: %i[email])
  end
end
