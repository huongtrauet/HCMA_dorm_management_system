class Manager < ApplicationRecord
  belongs_to :user, as: :user_duty

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

  validates :email, presence: true, allow_nil: false,
    length: {maximum: Settings.validations.manager.email.max_length},
    format: {with: Settings.validations.manager.email.regex},
    uniqueness: {case_sensitive: false}
  validates :phone_number, presence: true, allow_nil: false,
    format: {with: Settings.validations.manager.phone_number.regex}

end
