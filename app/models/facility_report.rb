class FacilityReport < ApplicationRecord
  belongs_to :reporter, dependent: :destroy
  validates :title, presence: true,
              length: {
                minimum: Settings.validations.facility_reports.title.min_length,
                maximum: Settings.validations.facility_reports.title.max_length
              }
  validates :description, presence: true,
              length: {
                minimum: Settings.validations.facility_reports.description.min_length,
                maximum: Settings.validations.facility_reports.description.max_length
              }      
end
