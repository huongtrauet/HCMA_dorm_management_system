class AddTypeAndReportIdToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :noti_type, :string, null: false
    add_column :notifications, :report_id, :integer, null: true
  end
end
