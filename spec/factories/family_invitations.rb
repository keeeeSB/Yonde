FactoryBot.define do
  factory :family_invitation do
    family
    email { 'tester@example.com' }
    token { 'MyString' }
  end
end
