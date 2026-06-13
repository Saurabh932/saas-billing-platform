class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.string :stripe_payment_id
      t.integer :amount_cents
      t.integer :status
      t.datetime :paid_at

      t.timestamps
    end
  end
end
