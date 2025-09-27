FactoryBot.define do
  factory :reading_log do
    user
    book
    read_on { '2025-09-01' }
    memo { 'とても喜んでいました。' }
  end
end
