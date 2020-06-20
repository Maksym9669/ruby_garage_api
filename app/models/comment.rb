class Comment < ApplicationRecord
    belongs_to :task
    validates :content, presence: true
    mount_uploader :attachment, AttachmentUploader
end
