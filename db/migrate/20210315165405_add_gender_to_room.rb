class AddGenderToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :gender, :string
  end
end
