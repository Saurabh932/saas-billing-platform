class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :account, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.string :invoice_number
      t.integer :ammount_cents
      t.integer :status
      t.date :due_date
      t.datetime :paid_at

      t.timestamps
    end
  end
end
