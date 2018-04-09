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
    url.present? ? url : "http://via.placeholder.com/420x280"
  end

  def sort_tags(names)
    return Tag.popular if names.nil?
    Tag.popular.sort do |a, b|
      if names.include?(a.name)
        a <=> b
      elsif !names.include?(a.name) && !names.include?(b.name)
        a <=> b
      else
        b <=> a
      end
    end
  end

end
