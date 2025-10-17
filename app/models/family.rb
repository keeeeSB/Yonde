class Family < ApplicationRecord
  has_one :family_library, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :children, dependent: :destroy
  has_many :reading_logs, dependent: :destroy

  accepts_nested_attributes_for :children

  validates :name, presence: true
end
