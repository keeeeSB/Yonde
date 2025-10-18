FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { "user#{_1}@example.com" }
    password { 'password12345' }
    confirmed_at { Time.current }
    family
  end
end
