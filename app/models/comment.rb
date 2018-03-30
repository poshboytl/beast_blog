class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :children, class_name: "Comment", foreign_key: "parent_id"

  validates :email, presence: true, unless: :user

  def can_delete_by?(user)
    return false if user.nil?
    user.admin? || user.author? || self.user == user
  end
end
