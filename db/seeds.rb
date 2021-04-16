# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Manager.create!(email: 'manager123@gmail.com', phone_number: "0972403331", password: '999999', password_confirmation: '999999', channel: "manager")

18.times do |index|
  Building.create!(name: "A#{index + 1}", total_floor: 10)
end

Room.create!(room_name: 'A1_0000', number_student: 4, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 1, status: 'UNFILLED')
Room.create!(room_name: 'A1_0202', number_student: 5, max_number_student: 6, room_type: 'VIP', gender: "MALE", building_id: 1, status: 'UNFILLED')
Room.create!(room_name: 'A2_0203', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 2)
Room.create!(room_name: 'A2_0304', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 2)
Room.create!(room_name: 'A2_0305', number_student: 0, max_number_student: 6, room_type: 'VIP', gender: "MALE", building_id: 2)
Room.create!(room_name: 'A3_0406', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 3)
Room.create!(room_name: 'A4_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 4)
Room.create!(room_name: 'A5_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 5)
Room.create!(room_name: 'A6_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 6)
Room.create!(room_name: 'A7_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 7)
Room.create!(room_name: 'A8_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 8)
Room.create!(room_name: 'A9_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 9)
Room.create!(room_name: 'A10_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 10)
Room.create!(room_name: 'A11_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 11)
Room.create!(room_name: 'A12_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 12)
Room.create!(room_name: 'A13_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 13)
Room.create!(room_name: 'A14_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 14)
Room.create!(room_name: 'A15_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 15)
Room.create!(room_name: 'A16_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 16)
Room.create!(room_name: 'A17_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 17)
Room.create!(room_name: 'A18_1007', number_student: 0, max_number_student: 6, room_type: 'NORMAL', gender: "FEMALE", building_id: 18)

Student.create!(student_id_number: '11111111', password: '11111111', name: 'Nguyen Thi Huong Tra', channel: "1", room_id: 1, extended_time: 6)
Student.create!(student_id_number: '22222222', password: '22222222', name: 'Vu Van Duc', channel: "2", room_id: 1, extended_time: 12)
Student.create!(student_id_number: '33333333', password: '33333333', name: 'Nguyen Duc Hung', channel: "3", room_id: 1, extended_time: 24)
Student.create!(student_id_number: '44444444', password: '44444444', name: 'Nguyen Anh Khoa', channel: "4", room_id: 1)

Student.create!(student_id_number: '55555555', password: '55555555', name: 'Nguyen Thu Thuy', channel: "5", room_id: 2, status: "ACTIVE", extended_time: 6)
Student.create!(student_id_number: '66666666', password: '66666666', name: 'Nguyen Thu Trang', channel: "6", room_id: 2, status: "ACTIVE", extended_time: 12)
Student.create!(student_id_number: '77777777', password: '77777777', name: 'Tran Minh Hung', channel: "7", room_id: 2, status: "ACTIVE", extended_time: 18)
Student.create!(student_id_number: '88888888', password: '88888888', name: 'Thai Duc Tung', channel: "8", room_id: 2, status: "ACTIVE", extended_time: 6)
Student.create!(student_id_number: '99999999', password: '99999999', name: 'Nguyen Thi Quynh Nhi', room_id: 2, channel: "9", status: "ACTIVE", extended_time: 6)

StudentProfile.create!(email: '11111111@gmail.com', student_id: 1, name: "Nguyen Thi Huong Tra")
StudentProfile.create!(email: '22222222@gmail.com', student_id: 2, name: "Vu Van Duc")
StudentProfile.create!(email: '33333333@gmail.com', student_id: 3, name: "Nguyen Duc Hung")
StudentProfile.create!(email: '44444444@gmail.com', student_id: 4, name: "Nguyen Anh Khoa")
StudentProfile.create!(email: '55555555@gmail.com', student_id: 5, name: "Nguyen Thu Thuy")
StudentProfile.create!(email: '66666666@gmail.com', student_id: 6, name: "Nguyen Thu Trang")
StudentProfile.create!(email: '77777777@gmail.com', student_id: 7, name: "Tran Minh Hung")
StudentProfile.create!(email: '88888888@gmail.com', student_id: 8, name: "Thai Duc Tung")
StudentProfile.create!(email: '99999999@gmail.com', student_id: 9, name: "Nguyen Thi Quynh Nhi")


10.times do 
  Post.create!(title: "Ban quản lý các công trình nhà ở và công sở thông báo",
              content: "Do tình hình diễn biến phức tạp của dịch Covid, đối với sinh viên chưa quay lại KTX sau thời gian nghỉ Tết, tạo thuận lợi cho sinh viên hiện đang ở KTX, Ban quản lý các công trình nhà ở và công sở thông báo chấp nhận sinh viên chuyển khoản tiền để gia hạn hợp đồng.
              Đề nghị sinh viên nộp tiền xin gia hạn.
              Khi chuyển khoản ghi rõ nội dung: HỌ VÀ TÊN và MÃ HỢP ĐỒNG
              Ví dụ: Nguyễn Văn An, MĐ1.0201.1.
              Số tài khoản: 21110001073604 - NH BIDV - Ban quản lý các công trình nhà ở và công sở
              Chú ý: Sinh viên không ghi đủ, đúng nội dung trên sẽ không được ghi nhận đã nộp tiền xin gia hạn.
              Mọi thắc mắc vui lòng liên hệ số điện thoại: 02460278793 (gặp chị Hà phòng kế toán)
              (Sinh viên đã nộp tiền vui lòng bỏ qua thông báo này)
              Trân trọng thông báo!",
              writer_name: "Huong Tra",
              manager_id: 1, 
              status: "POSTED")
end

10.times do 
  ServiceCharge.create(
    water_price: "200000",
    electricity_price: "100000", 
    total_price: "300000", 
    status: "PAID",
    month: 1, 
    year: 2010, 
    room_id: 2,
    payer: "Huong Tra",
    paid_at: DateTime.strptime("09/01/2009", "%m/%d/%Y") 
  )
end

10.times do 
  ServiceCharge.create(
    water_price: "100000",
    electricity_price: "50000", 
    total_price: "150000", 
    status: "UNPAID",
    month: 2, 
    year: 2011, 
    room_id: 3,
    payer: "JOHN",
    paid_at: DateTime.strptime("09/01/2009", "%m/%d/%Y") 
  )
end

10.times do |index|
  ComplaintReport.create(
    title: "Tình hình kiến ba khoang ở các phòng",
    description: "Hiện tại phòng em 1410 và các phòng cùng tầng có rất nhiều kiến ba khoang, gây ảnh hưởng đến sức khoẻ sinh viên. Mong ban quản lý sớm có biện pháp khắc phục",
    status: "PENDING",
    student_id: 1,
    index: index + 1
  )
end

10.times do |index|
  ComplaintReport.create(
    title: "Tình hình kiến ba khoang ở các phòng",
    description: "Hiện tại phòng em 1410 và các phòng cùng tầng có rất nhiều kiến ba khoang, gây ảnh hưởng đến sức khoẻ sinh viên. Mong ban quản lý sớm có biện pháp khắc phục",
    status: "APPROVED",
    student_id: 1,
    index: index + 6
)
end

10.times do |index|
  FacilityReport.create!(
    title: "Báo cáo hỏng thiết bị", 
    description: "Hiện tại phòng 1410 bị hỏng bình nóng lạnh, mong ban quản lý sớm có biện pháp sửa chữa.", 
    student_id: 1,
    index: index + 1
  )
end

10.times do |index|
  FacilityReport.create(
    title: "Báo cáo hỏng thiết bị",
    description: "Hiện tại phòng 1410 bị hỏng bình nóng lạnh, mong ban quản lý sớm có biện pháp sửa chữa.",
    status: "APPROVED",
    student_id: 1,
    index: index + 6
)
end

10.times do |index|
  FacilityReport.create(
    title: "Báo cáo hỏng thiết bị",
    description: "Hiện tại phòng 1410 bị hỏng bình nóng lạnh, mong ban quản lý sớm có biện pháp sửa chữa.",
    status: "REJECTED",
    student_id: 1,
    index: index + 11
)
end

10.times do |index|
  FormRequest.create(
    form_type: "The Confirmation of temporary residence",
    description: "Khi nào về Sài Gòn cậu nhớ gọi cho tôi Bất kể là mùa mưa hay mùa nắng",
    status: "PENDING",
    student_id: 1,
    index: index + 1
)
end

10.times do |index|
  Facility.create(
    name: "Bàn học",
    detail: "Bàn học 4 chân",
    room_id: 2
)
end
