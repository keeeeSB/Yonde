class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :reading_log

  validates :body, presence: true

  scope :default_order, -> { order(created_at: :desc, id: :desc) }
end
