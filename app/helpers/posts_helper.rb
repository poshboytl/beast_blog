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
    URI.encode("https://twitter.com/intent/tweet?text=#{post.title}&url=#{post_url_with_slug(post)}")
  end

  def share2weibo(post)
    URI.encode("https://service.weibo.com/share/share.php?url=#{post_url_with_slug(post)}&title=#{post.title}&appke=''")
  end

  def cover_image(post)
    url = post.cover&.url(:thumb)
    # url.present? ? url : asset_pack_path("src/images/cover.jpg")
    url.present? ? url : asset_pack_path('src/images/cover_small.png')
  end

  def cover_image_large(post)
    url = post.cover&.url
    url.present? ? url : asset_pack_path('src/images/cover_large.png')
  end

  def sort_tags(names)
    popular = Tag.popular
    return Tag.popular if names.nil?
    tags = popular.where(name: names)
    tags | popular
  end

end
