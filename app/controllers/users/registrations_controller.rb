class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if session[:pending_invitation_token]
        invitation = FamilyInvitation.find_by(token: session[:pending_invitation_token])
        if invitation
          ActiveRecord::Base.transaction do
            user.update!(family: invitation.family)
            invitation.update!(accepted_at: Time.current)
            session.delete(:pending_invitation_token)
          end
        end
      end
    end
  end
end
