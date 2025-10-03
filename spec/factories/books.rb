FactoryBot.define do
  factory :book do
    title { 'おしり探偵' }
    published_date { '2025-01-01' }
    description { 'みんな大好きおしり探偵' }
    page_count { 30 }
    image_url { 'MyString' }
  end
end
