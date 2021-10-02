class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :liker, foreign_key: { to_table: :users }, null: false
      t.references :liked, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
