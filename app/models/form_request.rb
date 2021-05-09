class FormRequest < ApplicationRecord
  belongs_to :student

  validates :form_type, presence: true, allow_nil: false
  validates :description, presence: true,
            length: {
              maximum: Settings.validations.form_request.description.max_length
            } 

end
