class FamilyLibrary < ApplicationRecord
  belongs_to :family
  has_many :family_books, dependent: :destroy
  has_many :books, through: :family_books
end
