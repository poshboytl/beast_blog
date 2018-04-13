module ApplicationHelper

  def title(page_title)
    content_for(:title) { "#{page_title} - #{ENV['site_name']}" }
    page_title
  end

  def render_avatar(user, width: 32, height: 32)
    image_tag(
      user.avatar.presence || 'avatar.png',
      class: "avatar",
      width: width,
      height: height,
      alt: user.name
    )
  end

  def gravatar_url(email, size = 64)
    gravatar = Digest::MD5::hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
  end

  def author_avatar(author)
    author.avatar_url.present? ? author.avatar_url(:thumb) : gravatar_url(author.email, 64)
  end

  def comment_avatar(comment)
    user = comment.user
    user.nil? ? gravatar_url(comment.email) : author_avatar(user)
  end

  def judge_active(controller, action)
    'active' if params[:controller] == controller.to_s && params[:action] == action.to_s
  end
end
