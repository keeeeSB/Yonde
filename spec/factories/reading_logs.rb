FactoryBot.define do
  factory :reading_log do
    read_on { '2025-10-07' }
    rating { 2 }
    memo { '良かったです。' }
    user
    book
    family
  end
end
