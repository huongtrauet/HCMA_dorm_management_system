# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Manager.create!(email: 'manager123@gmail.com', phone_number: "0972403331", password: '999999', password_confirmation: '999999', channel: "manager")
Room.create!(room_name: 'A01', number_student: 1, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE")
Room.create!(room_name: 'A02', number_student: 5, max_number_student: 6, room_type: 'VIP', gender: "MALE")
Student.create!(student_id_number: '11111111', password: '11111111', name: 'Huong Tra', channel: "1", room_id: 1)
Student.create!(student_id_number: '22222222', password: '22222222', name: 'Huong Giang', channel: "2", room_id: 1)
Student.create!(student_id_number: '33333333', password: '33333333', name: 'Huong Quynh', channel: "3", room_id: 1)
Student.create!(student_id_number: '44444444', password: '44444444', name: 'Quynh Hoa', channel: "4", room_id: 1)

Student.create!(student_id_number: '55555555', password: '55555555', name: 'Bao Ngoc', channel: "5", room_id: 2, status: "ACTIVE")
Student.create!(student_id_number: '66666666', password: '66666666', name: 'Van Duc', channel: "6", room_id: 2, status: "ACTIVE")
Student.create!(student_id_number: '77777777', password: '77777777', name: 'Tien Dung', channel: "7", room_id: 2, status: "ACTIVE")
Student.create!(student_id_number: '88888888', password: '88888888', name: 'Vu Duc Dam', channel: "8", room_id: 2, status: "ACTIVE")

Student.create!(student_id_number: '99999999', password: '99999999', name: 'Ngoc Nga', room_id: 2, channel: "9", status: "ACTIVE")
StudentProfile.create!(email: '11111111@gmail.com', identity_card_number: "11111111", student_id: 1)
StudentProfile.create!(email: '22222222@gmail.com', identity_card_number: "22222222", student_id: 2)
StudentProfile.create!(email: '33333333@gmail.com', identity_card_number: "33333333", student_id: 3)
StudentProfile.create!(email: '44444444@gmail.com', identity_card_number: "44444444", student_id: 4)
StudentProfile.create!(email: '55555555@gmail.com', identity_card_number: "55555555", student_id: 5)
StudentProfile.create!(email: '66666666@gmail.com', identity_card_number: "66666666", student_id: 6)
StudentProfile.create!(email: '77777777@gmail.com', identity_card_number: "77777777", student_id: 7)
StudentProfile.create!(email: '88888888@gmail.com', identity_card_number: "88888888", student_id: 8)
StudentProfile.create!(email: '99999999@gmail.com', identity_card_number: "99999999", student_id: 9)



Post.create!(title: "Form validation requires passing in a validation object with the rules required to validate your form.",
            content: "Form validation requires passing in a validation object with the rules required to validate your form.",
            writer_name: "Huong Tra",
            manager_id: 1, 
            status: "POSTED")
5.times do
  FacilityReport.create!(title: "Facility reports!!!!!", description: "A modal can open a second modal. If you use allowMultiple: 
                          true parameter the second modal will be opened on top of the first modal.
                          Otherwise the modal will be closed before the second modal is opened.", student_id: 1)
end

10.times do 
  ServiceCharge.create(
    water_price: "5000",
    electricity_price: "5000", 
    total_price: "10000", 
    status: "PAID",
    month: 1, 
    year: 2010, 
    room_id: 1,
    payer: "Huong Tra",
    paid_at: DateTime.strptime("09/01/2009", "%m/%d/%Y") 
  )
end
