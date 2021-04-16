class Room < ApplicationRecord
  after_commit :update_floor, on: [:create]
  after_commit :update_building, on: [:create, :update]

  has_many :service_charges, dependent: :destroy
  has_many :facilities, dependent: :destroy
  has_many :students
  belongs_to :building

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
  validates :status, presence: true, allow_nil: false, inclusion: { in: ['PENDING', 'UNFILLED','FULL']}

  def update_floor
    floor = self.room_name.split('_')[1][0,2].to_i
    self.update(floor: floor)
  end

  def update_building
    self.building.update(full_room_quantity: self.building.rooms.where(status: 'FULL').count)
    self.building.update(unfilled_room_quantity: self.building.rooms.where(status: 'UNFILLED').count)
    self.building.update(pending_room_quantity: self.building.rooms.where(status: 'PENDING').count)

    if self.has_problem == true
      self.building.update_attribute(:has_problem, true)
    end
    if self.building.rooms.where(has_problem: true).length == 0
      self.building.update_attribute(:has_problem, false)
    end
  end
end
