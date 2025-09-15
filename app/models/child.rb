class Child < ApplicationRecord
  belongs_to :family

  enum :gender, { male: 0, female: 1 }

  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
end
