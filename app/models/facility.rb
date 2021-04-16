class Facility < ApplicationRecord
  after_commit :update_room, on: [:update]
  belongs_to :room
  validates :name, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.facility.name.max_length}
  validates :quantity, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: 0}
  validates :status, presence: true, allow_nil: false
  validates :detail, presence: true, allow_nil: false,
            length: {maximum: Settings.validations.facility.description.max_length}
  mount_uploaders :images, PictureUploader
  serialize :images

  def update_room
    if self.status == "REPAIRING" || self.status == "BROKEN"
      self.room.update_attribute(:has_problem, true)
    end
    if self.room.facilities.where(status: 'REPAIRING').length == 0 && self.room.facilities.where(status: 'BROKEN').length == 0
      self.room.update_attribute(:has_problem, false)
    end
  end
end
