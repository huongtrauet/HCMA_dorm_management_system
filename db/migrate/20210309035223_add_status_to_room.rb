class AddStatusToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :status, :string, default: 'PENDING'
  end
end
