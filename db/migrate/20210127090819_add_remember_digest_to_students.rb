class AddRememberDigestToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :remember_digest, :string
  end
end
