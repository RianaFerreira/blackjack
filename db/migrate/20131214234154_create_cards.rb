class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :rank
      t.integer :card_value
      t.integer :deck_id
    end
    add_index :cards, :deck_id
  end

end
