class AddDenyReasonToComplaintReport < ActiveRecord::Migration[6.0]
  def change
    add_column :complaint_reports, :reject_reason, :string, default: "We are currently unable to process your request.Any questions please contact the management directly"
  end
end
