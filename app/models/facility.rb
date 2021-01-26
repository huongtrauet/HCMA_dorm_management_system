class Facility < ApplicationRecord
  belongs_to :room
  validates :name, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.facility.name.max_length}
  validates :quantity, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: 0}
  validates :status, presence: true, allow_nil: false,
  validates :description, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.facility.description.max_length,
                    minimum: Settings.validations.facility.description.min_length}
  
end
