class LibraryBook < ApplicationRecord
  belongs_to :library
  belongs_to :book

  validates :library_id, unique: { scope: :book_id }
end
