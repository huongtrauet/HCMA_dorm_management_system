class AddChannelToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :channel, :string
  end
end
