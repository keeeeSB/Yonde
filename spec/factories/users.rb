FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:user) { "user#{_1}@example.com" }
    password { 'password12345' }
  end
end
