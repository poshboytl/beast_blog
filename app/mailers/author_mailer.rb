class AuthorMailer < ApplicationMailer

  def password_reset(author)
    @author = author
    mail to: author.email, subject: 'Password reset'
  end

end
