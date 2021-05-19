class Manager < ApplicationRecord
  # belongs_to :user, as: :user_duty
  attr_accessor :remember_token, :reset_token
  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: :sender_id,
    dependent: :destroy
  has_many :active_notifications, class_name: Notification.name,
    foreign_key: :receiver_id,
    dependent: :destroy
  # has_many :notifications, through: :passive_notifications,
  #   source: :receiver, source_type: Manager.name
  # has_many :sent_notifications, through: :active_notifications,
  #   source: :sender, source_type: Manager.name

  has_many :notifications, as: :receiver
  has_many :sent_notifications, as: :sender
  has_many :posts

  validates :email, presence: true, allow_nil: false,
    length: {maximum: 255},
    format: {with: Settings.validations.manager.email.regex},
    uniqueness: {case_sensitive: false}
  validates :phone_number, presence: true, allow_nil: false,
    format: {with: Settings.validations.manager.phone_number.regex}

  has_secure_password
  

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = Manager.new_token #taoj remember_token luu vao cookies remember_digest vao db
    update_attribute(:remember_digest, Manager.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = Manager.new_token
    update reset_digest: Manager.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
