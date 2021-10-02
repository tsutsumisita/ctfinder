class CreateDirectMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :direct_messages do |t|
      t.references :matching, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
