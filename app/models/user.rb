class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :profile_image

  validates :name, presence: true
  validates :profile_image, blob: {
    content_type: %w[image/png image/jpg image/jpeg],
    size_range: 1..(5.megabytes)
  }
end
