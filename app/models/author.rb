class Author < ApplicationRecord
  has_many :authorships, dependent: :restrict_with_error
  has_many :books, through: :authorships

  validates :name, presence: true, uniqueness: true
end
