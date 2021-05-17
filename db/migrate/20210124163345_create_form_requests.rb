class CreateFormRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :form_requests do |t|
      t.string :form_type, null: false
      t.longtext :description, null: false
      t.string :status, null: false, default: "PENDING"
      t.integer :index, null: false

      t.timestamps
    end
  end
end
