# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Manager.create!(email: 'manager123@gmail.com', phone_number: "0972403331", password: '999999', password_confirmation: '999999', channel: "manager")
Room.create!(room_name: 'A01', number_student: 5, max_number_student: 6, room_type: 'NORMAL')
Room.create!(room_name: 'A02', number_student: 1, max_number_student: 6, room_type: 'VIP')
Student.create!(student_id_number: '88888888', password: '88888888', name: 'Huong Tra', channel: "1")
Student.create!(student_id_number: '11111111', password: '11111111', name: 'Huong Tra', room_id: 2, channel: "2" )
StudentProfile.create!(email: '88888888@gmail.com', identity_card_number: "88888888", student_id: 1)
StudentProfile.create!(email: '11111111@gmail.com', identity_card_number: "11111111", student_id: 2)
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
