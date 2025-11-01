class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :family, optional: true
  has_many :reading_logs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :profile_image do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validates :name, presence: true
  validates :profile_image, blob: {
    content_type: %w[image/png image/jpg image/jpeg],
    size_range: 1..(5.megabytes),
  }

  scope :default_order, -> { order(id: :asc) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }
end
