class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :plan

  enum :status, {
    active: 0,
    past_due: 1,
    cancelled: 2
  }
end
