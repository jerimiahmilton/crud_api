FactoryBot.define do
  factory :line_item do
    price { Faker::Commerce.price }
    qty { Faker::Number.between(1, 1000) }
    description { Faker::Commerce.product_name }
    order
  end
end
