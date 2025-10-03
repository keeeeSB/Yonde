class FamilyLibrary < ApplicationRecord
  belongs_to :family
  has_many :library_books, dependent: :destroy
  has_many :books, through: :library_books
end
