class Invitation < ApplicationRecord
  attr_accessor :password, :password_confirmation

  VALID_TIME_INTERVAL = 240.hours

  validates :password, confirmation: true
  validates :code, presence: true, uniqueness: true
  validates :expired_at, :name, presence: true
  # format same with author email regex
  validates :email, presence: true, length: { maximum: 255 }, format: { with: Author::VALID_EMAIL_REGEX }

  belongs_to :author, class_name: 'Author', foreign_key: 'author_id', optional: true

  before_validation :init
  after_commit :send_mail, on: :create

  def active
    return unless available?
    ActiveRecord::Base.transaction do
      author = Author.create!(name: self.name, email: self.email, password: self.password)
      self.update!(author_id: author.id, used: true) if author.valid?
      self
    end
  rescue ActiveRecord::RecordInvalid => e
    self.errors.add(:author, e.record.errors.full_messages.join(", "))
    return false
  end

  def available?
    unused? && unexpired?
  end

  def ready?
    if self.password.present?
      true
    else
      errors.add :password, I18n.t('activerecord.errors.models.invitation.no_password') if self.password.blank?
      false
    end
  end

  private

  def unused?
    !used
  end

  def unexpired?
    Time.current < self.expired_at
  end

  def init
    set_code if self.code.blank?
    set_expired_at if self.expired_at.blank?
  end

  def set_code
    begin
      self.code = SecureRandom.hex
    end while Invitation.where(code: self.code).any?
  end

  def set_expired_at
    self.expired_at = Time.current + VALID_TIME_INTERVAL
  end

  def send_mail
    # Disable email sending temporary
    InvitationMailer.invite_email(self).deliver_later
  end
end
