class Book < ApplicationRecord
  has_many :libraries, dependent: :destroy

  validates :title, presence: true
  validates :published_date, presence: true
  validates :description, presence: true
  validates :isbn, presence: true
  validates :page_count, presence: true
  validates :image_url, presence: true

  scope :default_order, -> { order(created_at: :asc, id: :asc) }
end
