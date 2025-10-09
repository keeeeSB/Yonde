class ChildReadingLog < ApplicationRecord
  belongs_to :child
  belongs_to :reading_log

  validates :child_id, uniqueness: { scope: :reading_log_id }
end
