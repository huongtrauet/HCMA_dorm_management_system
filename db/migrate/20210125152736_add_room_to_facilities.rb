class AddRoomToFacilities < ActiveRecord::Migration[6.0]
  def change
    add_reference :facilities, :room, null: false, foreign_key: true
  end
end
