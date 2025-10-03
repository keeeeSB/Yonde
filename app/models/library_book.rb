class LibraryBook < ApplicationRecord
  belongs_to :family_library
  belongs_to :book

  validates :family_library_id, uniqueness: { scope: :book_id }
end
