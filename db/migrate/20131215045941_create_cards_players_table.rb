class CreateCardsPlayersTable < ActiveRecord::Migration
  def change
    create_table :cards_players do |t|
      t.references :card
      t.references :player
    end
  end
end
