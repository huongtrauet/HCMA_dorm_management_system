class AddRoomToStudents < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :room, null: false, foreign_key: true, default: 1
  end
end
