class AddReporterToFacilityReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :facility_reports, :reporter, null: false, foreign_key: { to_table: :students }
  end
end
