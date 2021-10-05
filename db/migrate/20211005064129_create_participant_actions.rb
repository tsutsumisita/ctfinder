class CreateParticipantActions < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_actions do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
