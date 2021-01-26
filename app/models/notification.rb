class Notification < ApplicationRecord
  belongs_to :receiver, polymorphic: true
  belongs_to :sender, polymorphic: true

  validates :message, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.notification.message.max_length}
  validates :sender_id, presence: true, allow_nil: false
  validates :receiver_id, presence: true, allow_nil: false
  validates :sender_type, presence: true, allow_nil: false
  validates :receiver_type, presence: true, allow_nil: false
end
