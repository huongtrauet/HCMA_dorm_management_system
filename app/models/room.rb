class Room < ApplicationRecord
  has_many :service_charges, dependent: :destroy
  has_many :facilities, dependent: :destroy
  has_many :students

  validates :room_name, presence: true, allow_nil: false, uniqueness: {
                                                              case_sensitive: true, 
                                                              message: ->(object, data) do
                                                              "Hey , #{data[:value]} is already taken."
                                                              end
                                                          },
            length: {maximum: Settings.validations.room.room_name.max_length}

  validates :number_student, presence: true, allow_nil: true,
            numericality: {greater_than_or_equal_to: 0, only_integer: true
                          }
  validates :max_number_student, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: 0,
                          message: "Max number students must be integer and greater than or equal to 0"
            }
  validates :room_type, presence: true, allow_nil: false, inclusion: { in: ['NORMAL', 'VIP']}
  validates :status, presence: true, allow_nil: false, inclusion: { in: ['READY', 'MAINTAINING', 'USING']}
end
