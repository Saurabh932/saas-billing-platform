class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :subdomain
      t.string :email
      t.string :stripe_customer
      t.integer :status

      t.timestamps
    end
  end
end
