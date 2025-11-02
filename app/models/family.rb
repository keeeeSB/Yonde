class Family < ApplicationRecord
  has_one :family_library, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :children, dependent: :destroy
  has_many :reading_logs, dependent: :destroy
  has_many :family_invitations, dependent: :destroy

  accepts_nested_attributes_for :children

  validates :name, presence: true

  scope :default_order, -> { order(id: :asc) }
end
