module CommentsHelper
  def can_delete_comment?(comment)
    return false if current_user.nil?
    current_user.admin? || current_user == comment.post.author || current_user == comment.user
  end
end
