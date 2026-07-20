FactoryBot.define do
  factory :plan do
    name { "Basic" }
    price_cents { 900 }
    interval { :month }
    stripe_price_id { "price_#{Faker::Alphanumeric.alphanumeric(number: 10)}" }
    status { :active }
    features { [ "Feature 1", "Feature 2" ] }
  end
end
