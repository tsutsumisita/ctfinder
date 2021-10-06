class CreateRecentActions < ActiveRecord::Migration[6.0]
  def change
    create_table :recent_actions do |t|
      t.integer :action
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
