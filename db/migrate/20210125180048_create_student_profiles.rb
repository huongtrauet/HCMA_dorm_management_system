class CreateStudentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :student_profiles do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :class_name
      t.string :name, null: false
      t.datetime :date_of_birth
      t.string :identity_card_number, null: true
      t.string :address
      t.string :phone_number
      t.string :gender
      t.string :avatar

      t.timestamps
    end
  end
end
