class Book < ApplicationRecord
  validates :title, presence: true
  validates :published_date, presence: true
  validates :description, presence: true
  validates :isbn, presence: true
  validates :page_count, presence: true
  validates :image_url, presence: true
end
