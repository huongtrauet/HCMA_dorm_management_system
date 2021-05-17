class ComplaintReport < ApplicationRecord
  belongs_to :student
  validates :title, presence: true,
            length: {
              maximum: Settings.validations.complaint_reports.title.max_length
            }
  validates :description, presence: true,
            length: {
              maximum: Settings.validations.complaint_reports.description.max_length
            }
end
