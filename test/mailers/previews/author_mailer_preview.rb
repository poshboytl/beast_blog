# Preview all emails at http://localhost:3000/rails/mailers/author_mailer
class AuthorMailerPreview < ActionMailer::Preview
  def password_reset
    author = Author.first
    author.create_reset_digest
    AuthorMailer.password_reset(author)
  end

end
