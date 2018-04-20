class AuthorMailer < ApplicationMailer

  def password_reset(author)
    set_logo_url

    @author = author
    mail to: author.email, subject: 'Password reset'
  end

end
