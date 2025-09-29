class Book < ApplicationRecord
  has_many :libraries, dependent: :destroy

  validates :title, presence: true
  validates :systemid, presence: true, uniqueness: true

  scope :default_order, -> { order(created_at: :asc, id: :asc) }
end
