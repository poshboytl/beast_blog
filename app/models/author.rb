class Author < User
  attr_accessor :reset_token

  RESET_VALID_TIME_INTERVAL = 24.hours

  has_secure_password

  has_many :posts
  has_many :photos

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  # validates :password, presence: true, on: [:create]
  validates :password, length: { minimum: 6 }, allow_blank: true

  def author?
    true
  end

  def create_reset_digest
    self.reset_token = SecureRandom.urlsafe_base64
    update_attribute(:reset_digest,  Author.digest(reset_token))
    update_attribute(:reset_expired_at, Time.current + RESET_VALID_TIME_INTERVAL)
  end

  def send_password_reset_email
    AuthorMailer.password_reset(self).deliver_now
  end

  def create_reset_digest_and_send_email
    create_reset_digest
    send_password_reset_email
  end

  # 如果指定的令牌和摘要匹配， 返回true
  def reset_authenticated?(token)
    return false if reset_digest.nil?
    BCrypt::Password.new(reset_digest).is_password?(token)
  end

  def self.authenticate(email, pass)
    author = Author.find_by(email: email)
    return author if author&.authenticate(pass)
    false
  end

  def password_reset_expired?
    reset_expired_at < Time.current
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def twitter_url
    return "" if twitter.blank?
    "https://twitter.com/#{twitter}"
  end

  def weibo_url
    return "" if weibo.blank?
    "https://weibo.com/#{weibo}"
  end

  def github_url
    return "" if github.blank?
    "https://github.com/#{github.split('/').last}"
  end

end
