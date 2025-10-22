FactoryBot.define do
  factory :comment do
    body { 'いいですね。' }
    user
    reading_log
  end
end
