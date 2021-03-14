class Notification < ApplicationRecord
  after_commit :notify_pusher, on: [:create, :update]
  # after_create :notify_pusher

  def notify_pusher
    Pusher.app_id = "1171566"
    Pusher.key = "29056021d38b15b42578"
    Pusher.secret = "b94a78fa0181b10a462c"
    Pusher.cluster = "ap1"
    Pusher.logger = Rails.logger
    Pusher.encrypted = true
    Pusher.trigger(self.receiver.channel, 'new', {
      notification: self
    })
  end

  belongs_to :receiver, polymorphic: true
  belongs_to :sender, polymorphic: true

  validates :message, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.notification.message.max_length}
  validates :sender_id, presence: true, allow_nil: false
  validates :receiver_id, presence: true, allow_nil: false
  validates :sender_type, presence: true, allow_nil: false
  validates :receiver_type, presence: true, allow_nil: false
end
