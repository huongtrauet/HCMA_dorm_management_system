class AddStatusToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :status, :string, default: 'READY'
  end
end
