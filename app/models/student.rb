class Student < ApplicationRecord
  attr_accessor :remember_token
  belongs_to :room
  has_one :student_profile, dependent: :destroy
  accepts_nested_attributes_for :student_profile, allow_destroy: true
  has_many :form_requests, dependent: :destroy
  has_many :complaint_reports, dependent: :destroy
  has_many :facility_reports, dependent: :destroy

  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: :sender_id,
    dependent: :destroy
  has_many :active_notifications, class_name: Notification.name,
    foreign_key: :receiver_id,
    dependent: :destroy
  # has_many :notifications, through: :passive_notifications,
  #   source: :receiver, source_type: Student.name
  # has_many :sent_notifications, through: :active_notifications,
  #   source: :sender, source_type: Student.name
  has_many :notifications, as: :receiver
  has_many :sent_notifications, as: :sender

  validates :student_id_number, presence: true, allow_nil: false,
            length: {
              minimum: Settings.validations.student.student_id_number.min_length,
              maximum: Settings.validations.student.student_id_number.max_length,
              too_short: "ma sinh vien qua ngan",
              too_long: "ma sinh vien qua dai"
            },
            uniqueness: {
              # object = person object being validated
              # data = { model: "Person", attribute: "Username", value: <username> }
              message: ->(object, data) do
                "Hey u! #{data[:value]} da duoc tao!!"
              end
            }
  validates :name, presence: true, allow_nil: false,
            length: {
              minimum: Settings.validations.student.name.min_length,
              maximum: Settings.validations.student.name.max_length,
              too_short: "Ten qua ngan!!",
              too_long: "Ten qua dai!!"
            }
  validates :check_in_date, presence: true, allow_nil: true
  validates :check_out_date, presence: true, allow_nil: true

  has_secure_password

  def Student.new_token
    SecureRandom.urlsafe_base64
  end

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
    self.remember_token = Student.new_token
    update_attribute(:remember_digest, Student.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
end
