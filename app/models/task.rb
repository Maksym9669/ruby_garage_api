class Task < ApplicationRecord
    belongs_to :project
    validates :name, presence: true, uniqueness: true
    validates :status, presence: true, inclusion: { in: %w(active done) }
end
