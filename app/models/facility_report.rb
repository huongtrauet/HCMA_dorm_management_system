class FacilityReport < ApplicationRecord
  belongs_to :student
  validates :title, presence: true,
              length: {
                maximum: Settings.validations.facility_reports.title.max_length
              }
  validates :description, presence: true,
              length: {
                maximum: Settings.validations.facility_reports.description.max_length
              }
end
