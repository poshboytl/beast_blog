class InvitationMailer < ApplicationMailer

  def invite_email(invitation)
    set_logo_url
    @invitation = invitation

    mail to: invitation.email, subject: ENV['SITE_NAME']
  end
end
