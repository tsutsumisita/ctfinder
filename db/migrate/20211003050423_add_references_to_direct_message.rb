class AddReferencesToDirectMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :direct_messages, :sender, null: false, foreign_key: { to_table: :users }
  end
end
