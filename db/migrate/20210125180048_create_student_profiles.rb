class CreateStudentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :student_profiles do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :class_name, null: false, default: "WAITING"
      t.string :name, null: false, default: "WAITING"
      t.datetime :date_of_birth, null: false, default: "01/01/2001"
      t.string :identity_card_number, null: false, index: {unique: true}
      t.string :address, null: false, default: "WAITING"
      t.string :phone_number, null: false, default: "0972403331"
      t.string :gender, null: false, default: "MALE"
      t.string :avatar, null: true

      t.timestamps
    end
  end
end
