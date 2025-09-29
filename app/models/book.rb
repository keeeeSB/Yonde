class Book < ApplicationRecord
  has_many :libraries, dependent: :destroy
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :library_books, dependent: :destroy

  validates :title, presence: true
  validates :systemid, presence: true, uniqueness: true

  scope :default_order, -> { order(created_at: :asc, id: :asc) }
end
