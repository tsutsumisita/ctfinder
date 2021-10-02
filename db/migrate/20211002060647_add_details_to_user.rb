class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :web, :integer
    add_column :users, :crypt, :integer
    add_column :users, :reversing, :integer
    add_column :users, :pwn, :integer
    add_column :users, :misc, :integer
    add_column :users, :self_introduction, :text
  end
end
