class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.string :stripe_subscription_id
      t.integer :status
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
