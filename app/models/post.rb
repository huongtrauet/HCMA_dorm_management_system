class Post < ApplicationRecord
  belongs_to :manager
  validates :title, presence: true, allow_nil: false, 
            length: {maximum: Settings.validations.post.title.max_length}
  validates :content, presence: true, allow_nil: true
  validates :writer_name, presence: true, allow_nil: false, 
            length: {maximum: Settings.validations.post.writer_name.max_length}
  validates :status, presence: true, allow_nil: false, inclusion: { in: ['POSTED', 'DELETED']}
  mount_uploaders :images, PictureUploader
  serialize :images
  # has_many_attached :images
end 
