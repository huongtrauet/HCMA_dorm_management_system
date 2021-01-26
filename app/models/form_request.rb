class FormRequest < ApplicationRecord
  belongs_to :requester, dependent: :destroy

  validates :type, presence: true, allow_nil: false
  validates :description, presence: true,
            length: {
              minimum: Settings.validations.form_request.description.min_length,
              maximum: Settings.validations.form_request.description.max_length
            } 

end
