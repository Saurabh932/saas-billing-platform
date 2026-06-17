class Account < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    has_many :invoices, dependent: :destroy
    has_many :payments, dependent: :destroy

    enum :status, {active: 0, suspended: 1, cancelled: 2}

    validates :name, presence: true
    validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :subdomain, presence: true, uniqueness: true, format: {with: /\A[a-z0-9]+\z/, message: "only lowercase letters, numbers and hyphens."}
end