class ReadingLog < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :family
  has_many :child_reading_logs, dependent: :destroy

  enum :rating, {
    bad: 1,
    normal: 2,
    good: 3,
  }

  validates :read_on, presence: true
  validates :rating, inclusion: { in: 1..3 }
  validates :memo, length: { maximum: 200 }
end
