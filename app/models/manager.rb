class Manager < ApplicationRecord
  # belongs_to :user, as: :user_duty
  attr_accessor :remember_token
  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: :sender_id,
    dependent: :destroy
  has_many :active_notifications, class_name: Notification.name,
    foreign_key: :receiver_id,
    dependent: :destroy
  has_many :notifications, through: :passive_notifications,
    source: :receiver, source_type: Manager.name
  has_many :sent_notifications, through: :active_notifications,
    source: :sender, source_type: Manager.name
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
    self.remember_token
    update_attribute(:remember_digest, Manager.digest(remember_token))
    debugger
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
