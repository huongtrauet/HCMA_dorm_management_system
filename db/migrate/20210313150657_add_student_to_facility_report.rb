class AddStudentToFacilityReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :facility_reports, :student, null: false, foreign_key: true
  end
end
