FactoryBot.define do
  factory :punk_listing do
    punk_id { 1 }
    for_sale { true }
    sale_price { "100000" }
  end
end
