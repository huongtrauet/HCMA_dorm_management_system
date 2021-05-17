class AddStatusToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :status, :string, default: "PENDING"
  end
end
