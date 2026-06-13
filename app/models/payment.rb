class Payment < ApplicationRecord
  belongs_to :invoice
  belongs_to :account
end
