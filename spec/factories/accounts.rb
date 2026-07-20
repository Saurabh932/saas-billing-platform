FactoryBot.define do
    factory :account do
        name { "Test Company" }
        email { Faker::Internet.email }
        subdomain { "company-#{SecureRandom.hex(4)}" }
        stripe_customer { "cus_#{Faker::Alphanumeric.alphanumeric(number: 10)}" }
        status { :active }
    end
end
