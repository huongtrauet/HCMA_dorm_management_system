class AddStudentToComplaintReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :complaint_reports, :student, null: false, foreign_key: true
  end
end
