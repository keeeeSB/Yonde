class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :reading_log

  validates :body, presence: true
end
