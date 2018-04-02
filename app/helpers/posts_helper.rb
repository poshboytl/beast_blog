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

  def md2html(md)
    return if md.nil?
    Post.md2html(md)
  end

  def post_url_with_slug(post)
    post.slug.present? ? post_url(id: post.slug) : post_url(post)
  end

  def share2twitter(post)
    "https://twitter.com/intent/tweet?text=#{post.title}&url=#{post_url_with_slug(post)}"
  end

  def share2weibo(post)
    "https://service.weibo.com/share/share.php?url=#{post_url_with_slug(post)}&title=#{post.title}&appke=''"
  end

end
