class AddDenyReasonToComplaintReport < ActiveRecord::Migration[6.0]
  def change
    add_column :complaint_reports, :reject_reason, :longtext
  end
end
