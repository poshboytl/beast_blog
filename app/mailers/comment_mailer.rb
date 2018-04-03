class CommentMailer < ApplicationMailer
  helper PostsHelper

  def notify_author(post)
    @post = post
    mail to: post.author.email, subject: t("comment_mailer.notify_author.subject")
  end

  def notify_parent(comment)
    @comment = comment
    parent = comment.parent

    mail to: parent.real_email, subject: t("comment_mailer.notify_parent.subject")
  end

end
