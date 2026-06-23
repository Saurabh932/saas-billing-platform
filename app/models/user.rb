class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :account
  enum :role, { member: 0, admin: 1, superadmin: 2 }
end
