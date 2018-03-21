class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true

  validates :email, presence: true, unless: :user

  def can_delete_by?(user)
    user.admin? || user.author? || self.user == user
  end
end
