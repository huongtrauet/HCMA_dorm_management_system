class AddRejectReasonToFacilityReport < ActiveRecord::Migration[6.0]
  def change
    add_column :facility_reports, :reject_reason, :string
  end
end
