FactoryBot.define do
  factory :family_invitation do
    family
    email { 'tester@example.com' }
    token { 'MyString' }
    accepted_at { '2025-10-23 00:17:33' }
  end
end
