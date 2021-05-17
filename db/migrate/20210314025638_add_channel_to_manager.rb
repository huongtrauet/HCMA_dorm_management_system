class AddChannelToManager < ActiveRecord::Migration[6.0]
  def change
    add_column :managers, :channel, :string
  end
end
