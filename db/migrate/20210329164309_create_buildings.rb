class CreateBuildings < ActiveRecord::Migration[6.0]
  def change
    create_table :buildings do |t|
      t.string :name
      t.integer :total_floor
      t.integer :full_room_quantity, default: 0
      t.integer :unfilled_room_quantity, default: 0
      t.integer :pending_room_quantity, default: 0
      t.boolean :has_problem, default: false

      t.timestamps
    end
  end
end
