module PostsHelper

  def post_path_with_slug(post)
    post.slug.present? ? post_path(id: post.slug) : post_path(post)
  end

  def post_title(post)
    post.title.presence || t('posts.no_title')
  end

  def can_edit?(post)
    return false if current_user.nil?
    current_user.admin? || current_user.id == post.author_id
  end

end
