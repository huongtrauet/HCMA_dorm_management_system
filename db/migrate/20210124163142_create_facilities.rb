class CreateFacilities < ActiveRecord::Migration[6.0]
  def change
    create_table :facilities do |t|
      t.integer :name, null: false, index: {unique: true}
      t.integer :quantity, null: false
      t.integer :status, null: false
      t.string :description

      t.timestamps
    end
  end
end
