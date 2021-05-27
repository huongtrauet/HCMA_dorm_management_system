class AddOrderToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :order_name, :integer
  end
end
