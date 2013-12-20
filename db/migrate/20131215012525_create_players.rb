class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :stand
      t.integer :win
      t.integer :lost
      t.integer :draw
      t.integer :game_id
      t.timestamps
    end
  end
end
