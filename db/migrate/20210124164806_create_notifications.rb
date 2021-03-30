class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.string :sender_type, null: false
      t.string :receiver_type, null: false
      t.boolean :is_read, null: false, default: 'false'
      t.integer :page

      t.timestamps
    end
  end
end
