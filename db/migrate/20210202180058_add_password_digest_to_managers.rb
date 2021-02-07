class AddPasswordDigestToManagers < ActiveRecord::Migration[6.0]
  def change
    add_column :managers, :password_digest, :string
  end
end
