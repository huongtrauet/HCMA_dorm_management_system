class Student < ApplicationRecord
  belongs_to :room, dependent: :destroy
  has_one :student_profile, dependent: :destroy
  has_many :form_requests, dependent: :destroy
  has_many :complaint_reports, dependent: :destroy
  has_many :facility_reports, dependent: :destroy

  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: :sender_id,
    dependent: :destroy
  has_many :active_notifications, class_name: Notification.name,
    foreign_key: :receiver_id,
    dependent: :destroy
  has_many :notifications, through: :passive_notifications,
    source: :receiver, source_type: Student.name
  has_many :sent_notifications, through: :active_notifications,
    source: :sender, source_type: Student.name

  validates :student_id_number, presence: true, allow_nil: false,
            length: {
              minimum: Settings.validations.student.student_id_number.min_length,
              maximum: Settings.validations.student.student_id_number.max_length,
              too_short: "nguyen thi huong tra xinh dep",
              too_long: "too long"
            },
            uniqueness: {
              # object = person object being validated
              # data = { model: "Person", attribute: "Username", value: <username> }
              message: ->(object, data) do
                "Hey #{object}, #{data[:value]} is already taken."
              end
            }
  validates :check_in_date, presence: true, allow_nil: true
  validates :check_out_date, presence: true, allow_nil: true

  has_secure_password
end
