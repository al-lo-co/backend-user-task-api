class Task < ApplicationRecord
  belongs_to :user

  validates :date, presence: true

  enum :status, { active: 0, inactive: 1 }
end
