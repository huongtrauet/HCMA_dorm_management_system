class ComplaintReport < ApplicationRecord
  belongs_to :student
  validates :title, presence: true,
            length: {
              minimum: Settings.validations.complaint_reports.title.min_length,
              maximum: Settings.validations.complaint_reports.title.max_length
            }
  validates :description, presence: true,
            length: {
              minimum: Settings.validations.complaint_reports.description.min_length,
              maximum: Settings.validations.complaint_reports.description.max_length
            }
end
