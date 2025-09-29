class Library < ApplicationRecord
  belongs_to :book
  belongs_to :family

  validates :book_id, uniqueness: { scope: :family_id }
end
