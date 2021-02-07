class Room < ApplicationRecord
  has_many :service_charges, dependent: :destroy
  has_many :facilities, dependent: :destroy
  has_many :students

  validates :room_name, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.room.room_name.max_length}
  validates :number_student, presence: true, allow_nil: true,
            numericality: {greater_than_or_equal_to: 0}
  validates :max_number_student, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: 0}
end
