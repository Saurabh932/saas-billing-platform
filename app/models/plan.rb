class Plan < ApplicationRecord
   has_many :subscriptions

   enum :status, { active: 0, inactive: 1 }
   enum :interval, { month: 0, year: 1 }

   validates :name, presence: true
   validates :price_cents, presence: true
   validates :stripe_price_id, presence: true

   def price_in_cents
       price_cents / 100.0
   end
end