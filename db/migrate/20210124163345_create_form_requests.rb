class CreateFormRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :form_requests do |t|
      t.integer :type, null: false
      t.string :description, null: false
      t.string :status, null: false, default: "PENDING"

      t.timestamps
    end
  end
end
