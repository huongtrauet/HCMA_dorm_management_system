class CreateStudentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :student_profiles do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :class_name, null: false
      t.string :name, null: false
      t.datetime :date_of_birth, null: false
      t.string :identity_card_number, null: false, index: {unique: true}
      t.string :address, null: false
      t.string :phone_number, null: false
      t.string :gender, null: false
      t.string :avatar, null: true

      t.timestamps
    end
  end
end
