class FamilyLibrary < ApplicationRecord
  belongs_to :book
  belongs_to :family
end
