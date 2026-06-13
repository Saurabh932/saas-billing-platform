class Invoice < ApplicationRecord
  belongs_to :account
  belongs_to :subscription
end
