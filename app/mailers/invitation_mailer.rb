class InvitationMailer < ApplicationMailer
  def family_invitation(invitation, inviter)
    @invitation = invitation
    @inviter = inviter
    @url = accept_family_invitation_url(token: invitation.token)
    mail to: @invitation.email, subject: 'アプリの招待メールが届きました。'
  end
end
