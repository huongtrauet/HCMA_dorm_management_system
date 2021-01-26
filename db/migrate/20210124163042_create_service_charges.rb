class CreateServiceCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :service_charges do |t|
      t.integer :water_price, null: false
      t.integer :electricity_price, null: false
      t.integer :total_price, null: false
      t.integer :status, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
