class CreateServiceCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :service_charges do |t|
      t.integer :water_price, null: false, default: 0
      t.integer :electricity_price, null: false, default: 0
      t.integer :total_price, null: false, default: 0
      t.string :status, null: false, default: "UNPAID"
      t.integer :month, null: false
      t.integer :year, null: false
      t.string :payer, null: false, default: "Payer"
      t.datetime :paid_at, null: true

      t.timestamps
    end
  end
end
