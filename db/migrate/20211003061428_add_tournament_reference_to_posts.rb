class AddTournamentReferenceToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :tournament, null: false, foreign_key: true
  end
end