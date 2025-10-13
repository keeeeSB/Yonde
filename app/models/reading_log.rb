class ReadingLog < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :family
  has_many :child_reading_logs, dependent: :destroy
  has_many :children, through: :child_reading_logs

  enum :rating, {
    bad: 1,
    normal: 2,
    good: 3,
  }

  scope :default_order, -> { order(created_at: :desc, id: :desc) }

  validates :read_on, presence: true
  validates :rating, presence: true
  validates :memo, length: { maximum: 200 }
end
