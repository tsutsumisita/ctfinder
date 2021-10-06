class Tatsumingomenne < ActiveRecord::Migration[6.0]
  def change
    drop_table :post_actions
    drop_table :participant_actions
  end
end
