class Family < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :children, dependent: :restrict_with_error
  has_many :libraries, dependent: :destroy
  has_many :books, through: :libraries

  accepts_nested_attributes_for :children

  validates :name, presence: true
end
