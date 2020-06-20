# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[active done] }
  after_create :set_priority

  def set_priority
    self.priority = id
    save
  end
end
