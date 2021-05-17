class AddResetToManager < ActiveRecord::Migration[6.0]
  def change
    add_column :managers, :reset_digest, :string
    add_column :managers, :reset_sent_at, :datetime
  end
end
