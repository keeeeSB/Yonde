class FamilyInvitation < ApplicationRecord
  belongs_to :family

  before_validation :generate_token, on: :create

  validates :email, presence: true
  validates :token, presence: true, uniqueness: true

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end
end
