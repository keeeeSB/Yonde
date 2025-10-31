class Like < ApplicationRecord
  belongs_to :user
  belongs_to :reading_log

  validates :user_id, uniqueness: { scope: :reading_log_id }
end
