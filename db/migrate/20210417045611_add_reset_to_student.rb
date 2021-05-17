class AddResetToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :reset_digest, :string
    add_column :students, :reset_sent_at, :datetime
  end
end
