FactoryBot.define do
  factory :reading_log do
    read_on { '2025-10-07' }
    rating { 1 }
    memo { 'MyText' }
    user { nil }
    book { nil }
    family { nil }
  end
end
