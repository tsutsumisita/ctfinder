class RenameCryptColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :crypt, :crypto
  end
end
