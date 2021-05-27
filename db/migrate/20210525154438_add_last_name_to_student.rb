class AddLastNameToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :last_name, :string
  end
end
