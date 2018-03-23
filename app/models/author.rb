class Author < User
  has_secure_password

  has_many :posts
  has_many :photos

  validates :email, presence: true, uniqueness: true

  # validates :password, presence: true, on: [:create]

  def author?
    true
  end

  def self.authenticate(email, pass)
    author = Author.find_by(email: email)
    return author if author&.authenticate(pass)
    false
  end

end
