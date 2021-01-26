class AddStudentToStudentProfiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_profiles, :student, null: false, foreign_key: true
  end
end
