class Post < ApplicationRecord
  belongs_to :manager
  validates :title, presence: true, allow_nil: false, 
            length: {maximum: Settings.validations.post.title.max_length}
  validates :content, presence: true, allow_nil: false, 
            length: {maximum: Settings.validations.post.content.max_length}
  validates :writer_name, presence: true, allow_nil: false, 
            length: {maximum: Settings.validations.post.writer_name.max_length}
  validates :status, presence: true, allow_nil: false, inclusion: { in: ['POSTED', 'DELETED']}
            
end
