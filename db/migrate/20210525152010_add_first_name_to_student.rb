class AddFirstNameToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :first_name, :string
  end
end
