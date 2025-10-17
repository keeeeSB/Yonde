FactoryBot.define do
  factory :book do
    title { 'おしり探偵' }
    published_date { '2025-01-01' }
    description { 'みんな大好きおしり探偵' }
    systemid { 'abcdefg12345' }
    page_count { 30 }
    image_url { Rails.root.join('spec/fixtures/files/sample.webp').to_s }
  end
end
