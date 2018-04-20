# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview

  def notify_author
    CommentMailer.notify_author(Post.first)
  end

  def notify_parent
    comment = Comment.first
    comment.parent = Comment.last
    CommentMailer.notify_parent(comment)
  end

end
