class ChangeAccountIdTypeInUsers < ActiveRecord::Migration[8.1]
  def change
    change_column :users, :account_id, :integer
  end
end
