class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_name, null: false, index: {unique: true}
      t.integer :number_student, null: false, default: 0
      t.integer :max_number_student, null: false
      t.string :room_type, null: false

      t.timestamps
    end
  end
end
