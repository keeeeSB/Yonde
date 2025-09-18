class Family < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :children, dependent: :restrict_with_error

  accepts_nested_attributes_for :children

  validates :name, presence: true
end
