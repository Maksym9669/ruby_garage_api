# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  validates :content, presence: true
  mount_uploader :attachment, AttachmentUploader
  validates :attachment, file_size: { less_than_or_equal_to: 10.megabytes }
  # File type validation is done on Carrierwave side
end
