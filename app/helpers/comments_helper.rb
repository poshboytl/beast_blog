module CommentsHelper
  def can_delete_comment?(comment)
    return false if current_user.nil?
    current_user.admin? || current_user == comment.post.author || current_user == comment.user
  end

  def comment_user_name(comment)
    name = comment&.user&.name || comment.name
    return name if name.present?
    t('helpers.anon_user')
  end

  def comment_by_author?(comment)
    return false if comment.nil?
    return false if comment.user.nil?
    comment.user == comment.post.author
  end
end
