FactoryBot.define do
  factory :order do
    description { Faker::IndustrySegments.sector }
    customer
  end
end
