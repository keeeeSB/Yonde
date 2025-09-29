class Author < ApplicationRecord
  has_many :authorships, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
