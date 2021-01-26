class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|      
      t.string :student_id_number, null: false, index: {unique: true}
      t.datetime :check_in_date
      t.datetime :check_out_date

      t.timestamps
    end
  end
end
