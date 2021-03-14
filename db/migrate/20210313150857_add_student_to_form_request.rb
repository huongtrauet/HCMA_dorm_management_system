class AddStudentToFormRequest < ActiveRecord::Migration[6.0]
  def change
    add_reference :form_requests, :student, null: false, foreign_key: true
  end
end
