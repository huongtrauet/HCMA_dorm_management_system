class AddRoomToServiceCharges < ActiveRecord::Migration[6.0]
  def change
    add_reference :service_charges, :room, null: false, foreign_key: true
  end
end
