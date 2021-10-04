class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.references :participant, null: true, foreign_key: true
      t.references :post, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
