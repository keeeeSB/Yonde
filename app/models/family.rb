class Family < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :children, dependent: :restrict_with_error

  validates :name, presence: true
end
