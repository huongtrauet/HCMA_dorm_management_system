class FormRequest < ApplicationRecord
  belongs_to :requester, class_name: Student.name, foreign_key: :user_id, dependent: :destroy

  validates :type, presence: true, allow_nil: false
  validates :description, presence: true,
            length: {
              minimum: Settings.validations.form_request.description.min_length,
              maximum: Settings.validations.form_request.description.max_length
            } 

end
