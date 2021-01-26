class CreateManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :managers do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
