class RenameAccountToAccountIdInUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :account, :account_id
  end
end
