class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :rank
      t.integer :deck_id
      t.timestamps
    end
  end
end
