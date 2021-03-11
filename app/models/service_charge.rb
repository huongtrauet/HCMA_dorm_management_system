class ServiceCharge < ApplicationRecord
  belongs_to :room, dependent: :destroy
  validates :water_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.water_price.minimum}
  validates :electricity_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.electricity_price.minimum}
  validates :total_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.total_price.minimum}
  validates :status, presence: true, allow_nil: false
  validates :month, presence: true, allow_nil: false
  validates :year, presence: true, allow_nil: false
  validates :payer, presence: true, allow_nil: false
  validates :paid_at, presence: true, allow_nil: true
  
end
