class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :children, class_name: "Comment", foreign_key: "parent_id"

  before_save :cook_content
  after_create_commit :notify

  def can_delete_by?(user)
    return false if user.nil?
    user.admin? || user.author? || self.user == user
  end

  def real_email
    email || user&.email
  end

  private

  def notify_author
    return if user_id == post.author_id
    return if parent&.user_id == post.author_id
    CommentMailer.notify_author(post).deliver_later
  end

  def notify_parent
    return if parent&.real_email.nil?
    return if parent.real_email == real_email
    CommentMailer.notify_parent(self).deliver_later
  end

  def notify
    notify_author
    notify_parent
  end

  # replace \r\n with <br/> for break line
  def cook_content
    return if self.content.nil?
    self.cooked_content = self.content.gsub(/\r\n/, "<br/>")
  end

end
