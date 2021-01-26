class ServiceCharge < ApplicationRecord
  belongs_to :room, dependent: :destroy

  validates :water_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.water_price.minimum}
  validates :electricity_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.electricity_price.minimum}
  validates :total_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.total_price.minimum}
  validates :status, presence: true, allow_nil: false
  validates :start_date, presence: true, allow_nil: false
  validates :end_date, presence: true, allow_nil: false
end
