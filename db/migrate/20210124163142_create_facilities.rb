class CreateFacilities < ActiveRecord::Migration[6.0]
  def change
    create_table :facilities do |t|
      t.string :name, null: false
      t.integer :quantity, null: false, default: 1
      t.string :status, null: false, default: 'NEW'
      t.string :detail
      t.string :images

      t.timestamps
    end
  end
end
