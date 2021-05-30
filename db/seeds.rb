# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Manager.create!(email: 'hcma_manager@gmail.com', phone_number: "0972403331", password: 'hcmamanager', password_confirmation: 'hcmamanager', channel: "manager")

18.times do |index|
  Building.create!(name: "A#{index + 1}", total_floor: 5)
end

Room.import_file File.open("#{Rails.root}/public/room.xlsx")
Student.import_file File.open("#{Rails.root}/public/sv.xlsx")

# Student.create!(student_id_number: '17021070', password: '17021070', name: 'Nguyễn Thị Hương Trà', channel: "1", room_id: 1, extended_time: 6)
# Student.create!(student_id_number: '17021076', password: '17021076', name: 'Vũ Văn Đức', channel: "2", room_id: 1, extended_time: 12)
# Student.create!(student_id_number: '17021071', password: '17021071', name: 'Nguyễn Đức Hùng', channel: "3", room_id: 1, extended_time: 24)
# Student.create!(student_id_number: '17021072', password: '17021072', name: 'Nguyễn Anh Khoa', channel: "4", room_id: 1)

# Student.create!(student_id_number: '17021073', password: '17021073', name: 'Nguyễn Đức Mạnh', channel: "5", room_id: 2, status: "ACTIVE", extended_time: 6)
# Student.create!(student_id_number: '17021074', password: '17021074', name: 'Nguyễn Thu Trang', channel: "6", room_id: 2, status: "ACTIVE", extended_time: 12)
# Student.create!(student_id_number: '17021075', password: '17021075', name: 'Trần Minh Hùng', channel: "7", room_id: 2, status: "ACTIVE", extended_time: 18)
# Student.create!(student_id_number: '17021077', password: '17021077', name: 'Thái Đức Tùng', channel: "8", room_id: 2, status: "ACTIVE", extended_time: 6)
# Student.create!(student_id_number: '17021078', password: '17021078', name: 'Nguyễn Bảo Minh Châu', room_id: 2, channel: "9", status: "ACTIVE", extended_time: 6)
# Student.create!(student_id_number: '17021079', password: '17021079', name: 'Nguyễn Thị Linh', room_id: 1, channel: "10", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021080', password: '17021080', name: 'Hồ Thị Diệu Linh', room_id: 1, channel: "11", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021081', password: '17021081', name: 'Đỗ Mai Trang', room_id: 1, channel: "12", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021082', password: '17021082', name: 'Đỗ Trang Trí', room_id: 1, channel: "13", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021083', password: '17021083', name: 'Nguyễn Mai Hương', room_id: 1, channel: "14", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021084', password: '17021084', name: 'Nguyễn Quỳnh Nhu', room_id: 1, channel: "15", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021085', password: '17021085', name: 'Trần Quỳnh Nhi', room_id: 1, channel: "16", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021086', password: '17021086', name: 'Phan Ánh Tuyết', room_id: 1, channel: "17", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021087', password: '17021087', name: 'Nguyễn Quang Đăng', room_id: 1, channel: "18", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021088', password: '17021088', name: 'Nguyễn Tuyết Mai', room_id: 1, channel: "19", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021089', password: '17021089', name: 'Nguyễn Thu Quỳnh', room_id: 1, channel: "20", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021090', password: '17021090', name: 'Nguyễn Hoàng Hà', room_id: 1, channel: "21", status: "PENDING", extended_time: 6)

# Student.create!(student_id_number: '17021073', password: '17021073', name: 'Nguyễn Đức Mạnh', channel: "5", room_id: 2, status: "ACTIVE", extended_time: 6)
# Student.create!(student_id_number: '17021074', password: '17021074', name: 'Nguyễn Thu Trang', channel: "6", room_id: 2, status: "ACTIVE", extended_time: 12)
# Student.create!(student_id_number: '17021075', password: '17021075', name: 'Trần Minh Hùng', channel: "7", room_id: 2, status: "ACTIVE", extended_time: 18)
# Student.create!(student_id_number: '17021077', password: '17021077', name: 'Thái Đức Tùng', channel: "8", room_id: 2, status: "ACTIVE", extended_time: 6)
# Student.create!(student_id_number: '17021078', password: '17021078', name: 'Nguyễn Bảo Minh Châu', room_id: 2, channel: "9", status: "ACTIVE", extended_time: 6)
# Student.create!(student_id_number: '17021079', password: '17021079', name: 'Nguyễn Thị Linh', room_id: 1, channel: "10", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021080', password: '17021080', name: 'Hồ Thị Diệu Linh', room_id: 1, channel: "11", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021081', password: '17021081', name: 'Đỗ Mai Trang', room_id: 1, channel: "12", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021082', password: '17021082', name: 'Đỗ Trang Trí', room_id: 1, channel: "13", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021083', password: '17021083', name: 'Nguyễn Mai Hương', room_id: 1, channel: "14", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021084', password: '17021084', name: 'Nguyễn Quỳnh Nhu', room_id: 1, channel: "15", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021085', password: '17021085', name: 'Trần Quỳnh Nhi', room_id: 1, channel: "16", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021086', password: '17021086', name: 'Phan Ánh Tuyết', room_id: 1, channel: "17", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021087', password: '17021087', name: 'Nguyễn Quang Đăng', room_id: 1, channel: "18", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021088', password: '17021088', name: 'Nguyễn Tuyết Mai', room_id: 1, channel: "19", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021089', password: '17021089', name: 'Nguyễn Thu Quỳnh', room_id: 1, channel: "20", status: "PENDING", extended_time: 6)
# Student.create!(student_id_number: '17021090', password: '17021090', name: 'Nguyễn Hoàng Hà', room_id: 1, channel: "21", status: "PENDING", extended_time: 6)

# StudentProfile.create!(email: '17021070@gmail.com', student_id: 1, name: "Nguyễn Thị Hương Trà", avatar: "https://i.pravatar.cc/150?img=3")
# StudentProfile.create!(email: '17021076@gmail.com', student_id: 2, name: "Vũ Văn Đức", avatar: "https://i.pravatar.cc/150?img=4" )
# StudentProfile.create!(email: '17021071@gmail.com', student_id: 3, name: "Nguyễn Đức Hùng", avatar: "https://i.pravatar.cc/150?img=5")
# StudentProfile.create!(email: '17021072@gmail.com', student_id: 4, name: "Nguyễn Anh Khoa", avatar: "https://i.pravatar.cc/150?img=6")
# StudentProfile.create!(email: '17021073@gmail.com', student_id: 5, name: "Nguyễn Đức Mạnh", avatar: "https://i.pravatar.cc/150?img=7")
# StudentProfile.create!(email: '17021074@gmail.com', student_id: 6, name: "Nguyen Thu Trang", avatar: "https://i.pravatar.cc/150?img=8")
# StudentProfile.create!(email: '17021075@gmail.com', student_id: 7, name: "Trần Minh Hùng", avatar: "https://i.pravatar.cc/150?img=9")
# StudentProfile.create!(email: '17021077@gmail.com', student_id: 8, name: "Thái Đức Tùng", avatar: "https://i.pravatar.cc/150?img=10")
# StudentProfile.create!(email: '17021078@gmail.com', student_id: 9, name: "Nguyễn Bảo Minh Châu", avatar: "https://i.pravatar.cc/150?img=11")
# StudentProfile.create!(email: '17021079@gmail.com', student_id: 10, name: "Nguyễn Thị Linh", avatar: "https://i.pravatar.cc/150?img=12")
# StudentProfile.create!(email: '17021080@gmail.com', student_id: 11, name: "Hồ Thị Diệu Linh", avatar: "https://i.pravatar.cc/150?img=13")
# StudentProfile.create!(email: '17021081@gmail.com', student_id: 12, name: "Đỗ Mai Trang", avatar: "https://i.pravatar.cc/150?img=14")
# StudentProfile.create!(email: '17021082@gmail.com', student_id: 13, name: "Đỗ Trang Trí", avatar: "https://i.pravatar.cc/150?img=15")
# StudentProfile.create!(email: '17021083@gmail.com', student_id: 14, name: "Nguyễn Mai Hương", avatar: "https://i.pravatar.cc/150?img=16")
# StudentProfile.create!(email: '17021084@gmail.com', student_id: 15, name: "Nguyễn Quỳnh Như", avatar: "https://i.pravatar.cc/150?img=17")
# StudentProfile.create!(email: '17021085@gmail.com', student_id: 16, name: "Trần Quỳnh Nhi", avatar: "https://i.pravatar.cc/150?img=18")
# StudentProfile.create!(email: '17021086@gmail.com', student_id: 17, name: "Phan Ánh Tuyết", avatar: "https://i.pravatar.cc/150?img=19")
# StudentProfile.create!(email: '17021087@gmail.com', student_id: 18, name: "Nguyễn Quang Đăng", avatar: "https://i.pravatar.cc/150?img=20")
# StudentProfile.create!(email: '17021088@gmail.com', student_id: 19, name: "Nguyễn Tuyết Mai", avatar: "https://i.pravatar.cc/150?img=21")
# StudentProfile.create!(email: '17021089@gmail.com', student_id: 20, name: "Nguyễn Thu Quỳnh", avatar: "https://i.pravatar.cc/150?img=22")
# StudentProfile.create!(email: '17021090@gmail.com', student_id: 21, name: "Nguyễn Hoàng Hà", avatar: "https://i.pravatar.cc/150?img=23")


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
Post.create!(title: "Ban quản lý các công trình nhà ở và công sở thông báo",
              content: "Đề nghị sinh viên có tên trong Danh sách nếu còn nguyện vọng ở KTX khẩn trương nộp tiền gia hạn tiền phòng.
              Sinh viên có 2 hình thức gia hạn: Chuyển khoản và nộp tiền trực tiếp.
              Cách 1: Chuyển khoản
              Khi chuyển khoản ghi rõ nội dung: HỌ VÀ TÊN và MÃ HỢP ĐỒNG
              Ví dụ: Nguyễn Văn An, MĐ1.0201.1.
              Số tài khoản: 21110001073604 - NH BIDV - Ban quản lý các công trình nhà ở và công sở
              Chú ý: Sinh viên không ghi đủ, đúng nội dung trên sẽ không được ghi nhận đã nộp tiền xin gia hạn.
              Cách 2: Nộp tiền trực tiếp
              Mọi thắc mắc vui lòng liên hệ số điện thoại: 02460278793 (gặp chị Hà phòng kế toán)
              (Sinh viên đã nộp tiền vui lòng bỏ qua thông báo này)
              Trân trọng thông báo!",
              writer_name: "Phạm Quỳnh",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "THÔNG BÁO!",
              content: "Chú ý: Các bạn chuyển khoản nhớ ghi đúng cú pháp nhé (tránh trường hợp chuyển khoản rồi nhưng ghi thiếu/ sai thông tin nên vẫn trong danh sách chưa nộp tiền).
              Những bạn đã nộp 600k tiền dịch vụ vệ sinh sẽ được tính sang tháng 7/2021.
              XX KHÔNG CHUYỂN TIỀN PHÒNG VÀO STK NÀY !! XX",
              writer_name: "Phạm Quỳnh",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "THÔNG BÁO!",
              content: "CỤC AN NINH MẠNG VÀ PHÒNG CHỐNG TỘI PHẠM SỬ DỤNG CÔNG NGHỆ CAO - BỘ CÔNG AN đề nghị người dân không sản xuất, 
              mua bán, vận chuyển, tàng trữ, sử dụng trái phép vũ khí, vật liệu nổ, công cụ hỗ trợ và đồ chơi nguy hiểm. Mọi hành vi vi 
              phạm sẽ bị xử lý nghiêm theo quy định của pháp luật.
              Để đảm bảo an toàn phòng cháy, chữa cháy và thoát nạn, Bộ Công an khuyến cáo cá nhân, 
              hộ gia đình: Không sắp xếp hàng hóa, vật dụng dễ cháy gần nguồn lửa, nguồn nhiệt; cẩn trọng khi đun nấu, thắp hương, 
              đốt vàng mã, sạc các thiết bị điện, điện tử; ngắt các thiết bị điện khi không sử dụng; không tàng trữ chất cháy, nổ; 
              không làm cản trở lối thoát nạn và có lối thoát nạn dự phòng; lắp đặt thiết bị báo cháy; trang bị phương tiện chữa cháy, 
              thoát nạn như: Bình chữa cháy, búa, xà beng, thang dây, thang hạ chậm, mặt nạ phòng độc...; khi có cháy, nổ, sự cố, tai nạn gọi 114.",
              writer_name: "Phạm Quỳnh",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "BQL KTX HCMA THÔNG BÁO ",
              content: "CỤC AN NINH MẠNG VÀ PHÒNG CHỐNG TỘI PHẠM SỬ DỤNG CÔNG NGHỆ CAO - BỘ CÔNG AN đề nghị người dân không sản xuất, 
              mua bán, vận chuyển, tàng trữ, sử dụng trái phép vũ khí, vật liệu nổ, công cụ hỗ trợ và đồ chơi nguy hiểm. Mọi hành vi vi 
              phạm sẽ bị xử lý nghiêm theo quy định của pháp luật.
              Để đảm bảo an toàn phòng cháy, chữa cháy và thoát nạn, Bộ Công an khuyến cáo cá nhân, 
              hộ gia đình: Không sắp xếp hàng hóa, vật dụng dễ cháy gần nguồn lửa, nguồn nhiệt; cẩn trọng khi đun nấu, thắp hương, 
              đốt vàng mã, sạc các thiết bị điện, điện tử; ngắt các thiết bị điện khi không sử dụng; không tàng trữ chất cháy, nổ; 
              không làm cản trở lối thoát nạn và có lối thoát nạn dự phòng; lắp đặt thiết bị báo cháy; trang bị phương tiện chữa cháy, 
              thoát nạn như: Bình chữa cháy, búa, xà beng, thang dây, thang hạ chậm, mặt nạ phòng độc...; khi có cháy, nổ, sự cố, tai nạn gọi 114.",
              writer_name: "Phạm Quỳnh",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "BQL KTX HCMA THÔNG BÁO ",
              content: "Sinh viên có tên trong danh sách đến phòng Dịch vụ và Quản lý sinh viên để nhận thẻ ra vào.
              Thời gian: Sáng 8h - 12h; Chiều 14h - 17h
              Trân trọng!",
              writer_name: "Hương Trà",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "NHẬN XÔ RÁC",
              content: "Còn một số phòng chưa nhận xô rác đề nghị các phòng cử đại diện xuống nhận nốt. Các bạn nhớ mang theo thẻ KTX nhé 😊",
              writer_name: "Hương Trà",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "📷📷📷 MỜI CÁC SV CÓ TÊN TRONG DANH SÁCH ĐẾN LẤY TIỀN THANH LÝ.",
              content: "BQL ĐÃ HOÀN THIỆN THỦ TỤC THANH LÝ CHO SINH VIÊN CÓ TÊN TRONG DS DƯỚI ĐÂY, ĐỀ NGHỊ SV ĐẾN GIẢI QUYẾT VÀO 02 NGÀY: THỨ 4 và THỨ 5 HÀNG TUẦN.
              Hiện nay BQL đã hoàn tất thủ tục thanh lý hợp đồng cho một số sinh viên.
              Các bạn sv thấy tên mình trong danh sách thì mời đến Khu nhà ở sinh viên Mỹ Đình 2 để giải quyết lấy tiền thanh lý.
              📷 Lưu ý:
              1. BQL chỉ giải quyết thủ tục trên vào thứ 4 và thứ 5 hàng tuần (Trong giờ hành chính).
              2. Địa điểm: Phòng Quản lý vận hành 1-tầng 1 Đơn nguyên 4.
              3. Khi đến vui lòng mang theo các giấy tờ liên quan đến Khu nhà, CMT hoặc Căn cước công dân và gặp C.Huyền hoặc C.Mai đọc PASS: EM ĐẾN LẤY TIỀN THANH LÝ nhé!!!
              4. MÃ HỢP ĐỒNG:
              MĐ4 : TÊN ĐƠN NGUYÊN 4.
              0706: SỐ PHÒNG 706.
              3: SỐ GIƯỜNG
              📷📷📷 Một số bạn sv cũng thanh lý HĐ nhưng chưa có tên trong danh sách do thủ tục chưa được giải quyết xong, BQL sẽ liên tục cập nhật thông tin nhé.
              Mọi thắc mắc các bn vui lòng ib hoặc gọi vào sđt của BQL.
              Tks all!",
              writer_name: "Hương Trà",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "THÔNG BÁO
                    V/v: SINH VIÊN QUÁ HẠN NỘP TIỀN NHÀ Ở",
              content: "Căn cứ Danh sách sinh viên đã quá hạn nộp tiền của BQL các công trình nhà ở và công sở,
              BQL KTX Mỹ Đình yêu cầu:
              - Sinh viên có tên trong danh sách phải làm thủ tục chuyển ra khỏi KTX ngay.
              - Sinh viên đã nộp tiền vẫn có tên vui lòng sang đối chiếu lại với chị Hà kế toán Ban nhà ở công sở.
              Yêu cầu các em nhanh chóng thực hiện!",
              writer_name: "Hương Trà",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "Ban quản lý Ký túc xá HCMA- Trung tâm Hỗ trợ sinh viên Chúc mừng Năm mới, năm TÂN SỬU!",
              content: "Nhằm bảo đảm an toàn và công tác phòng, chống dịch COVID-19, Ban Quản lý KTX Mỹ Đình thông báo:
              1. Ngày đầu tiên quay về Ký túc xá, tất cả học sinh, sinh viên phải thực hiện khai báo y tế theo mẫu tại quầy trực bảo vệ.
              2. Đối với học sinh, sinh viên ở vùng dịch, yêu cầu thực hiện khai báo y tế tại trung tâm y tế dự phòng Phường Mỹ Đình 2- Quận Nam Từ liêm- Hà Nội. (BS Toàn: 0976899016)
              3. Thực hiện nghiêm các biện pháp phòng, chống dịch và yêu cầu 5K: Khẩu trang- Khử khuẩn- Khoảng cách- Không tập chung- Khai báo Y tế. Khi có triệu chứng nghi nhiễm COVID-19( sốt, ho, khó thở, đau ngực) cần đến ngay cơ sở y tế gần nhất để khám, tư vấn và điều trị kịp thời.
              BQL đề nghị toàn thể HSSV thực hiện nghiêm túc theo các nội dung thông báo này.",
              writer_name: "Hương Trà",
              manager_id: 1, 
              status: "POSTED")
Post.create!(title: "THÔNG BÁO!",
              content: "LỊCH NỘP TIỀN DỊCH VỤ VỆ SINH NĂM 2021
              Các bạn chú ý thời gian và địa điểm nộp nhé ~ 
              Mọi ý kiến đóng góp BQL tiếp nhận trực tiếp tại phòng quản lý sinh viên 🧏🏻‍♀️ xin cảm ơnnnn 😊",
              writer_name: "Hương Trà",
              manager_id: 1, 
              status: "POSTED")

ComplaintReport.create(
  title: "Tình hình kiến ba khoang ở các phòng",
  description: "Hiện tại phòng em 1410 và các phòng cùng tầng có rất nhiều kiến ba khoang, gây ảnh hưởng đến sức khoẻ sinh viên. Mong ban quản lý sớm có biện pháp khắc phục",
  status: "PENDING",
  student_id: 1,
  index: 1
)

ComplaintReport.create(
  title: "Tình hình muỗi vằn",
  description: "Các phòng tại ký túc xá hiện nay rất nhiều muỗi vằn, mong quản lý có biện pháp khắc phục cho học viên ạ",
  student_id: 1,
  index: 2
)

ComplaintReport.create(
  title: "Bảo vệ không nghiêm ngặt",
  description: "Tại đơn nguyên 2 KTX xuất hiện rất nhiều học viên lạ mặt gõ cửa các phòng vào buổi trưa ngủ ạ. Mong ban quản lý sớm tìm cách giải quyết",
  student_id: 1,
  index: 3
)

ComplaintReport.create(
  title: "Vệ sinh không tốt",
  description: "Hàng tháng chúng em phải đóng tiền vệ sinh 100 nghìn cho một tháng để được vệ sinh, tuy nhiên cô lao công chỉ đến dọn 1 tháng 1 lần ạ.",
  student_id: 1,
  index: 4
)

ComplaintReport.create(
  title: "Khu vực căng tin quá ồn ào",
  description: "Nay đã vào tháng 4, tháng thi cử nhưng tầng dưới căng tin hát hò đến 11 giờ đêm khiến bọn em không thể ôn bài. Đề nghị ban quản lý có cách khắc phục kịp thời ạ",
  student_id: 1,
  index: 5
)

FacilityReport.create(
  title: "Báo cáo hỏng thiết bị", 
  description: "Hiện tại phòng 1410 bị hỏng bình nóng lạnh, mong ban quản lý sớm có biện pháp sửa chữa.", 
  student_id: 1,
  index: 1
)

FacilityReport.create(
  title: "Hỏng máy giặt", 
  description: "Hiện tại phòng em 1410 bị hỏng máy giặt đã 3 tháng nay rồi ạ. Máy cắm điện vào nhưng không quay ạ", 
  student_id: 1,
  index: 2
)

FacilityReport.create(
  title: "Hỏng quạt", 
  description: "Phòng em hoảng quạt 6 tháng nay rồi, nay đã vào mùa nóng, mong ban quản lý kịp thời sửa để bọn em sử dụng qua mùa hè ạ", 
  student_id: 1,
  index: 3
)

FacilityReport.create(
  title: "Hỏng bàn học", 
  description: "Phòng 1410 hiện đang bị hỏng 2 bàn học. Bàn bị rơi ốc vít ạ. Mong ban quản lý kịp thời sửa chữa để bọn em tiếp tục học tập ạ", 
  student_id: 1,
  index: 4
)

FacilityReport.create(
  title: "Hỏng khoá cửa chính", 
  description: "Hiện tại phòng em 1410 bị hỏng khoá cửa chính, chìa khoá nào cũng không mở được. Hiện bọn em không ra được khỏi phòng, mong ban
    quản lý sửa gấp cho bọn em ạ!!!",
  student_id: 1,
  index: 5
)

FormRequest.create(
  form_type: "Thẻ ra vào",
  description: "Hiện tại em bị mất thẻ ra vào KTX, xin ban quản lý cấp lại cho em thẻ khác để em có thể ra vào KTX ạ",
  status: "PENDING",
  student_id: 1,
  index: 1
)
FormRequest.create(
  form_type: "Giấy tạm trú tạm vắng",
  description: "Hiện tại em cần giấy tạm trú tạm vắng để nộp lên công ty thực tập, mong KTX có thể cấp sớm giúp em ạ",
  status: "PENDING",
  student_id: 1,
  index: 2
)
FormRequest.create(
  form_type: "Giấy chứng nhận nội trú tại ký túc xá Học viện",
  description: "Hiện tại em đang làm hồ sơ xin miễn giảm tiền học phí ở trường, trong đó có yêu cầu giấy chứng nhận nội trú tại ký túc xá.
  Vậy nên em mong ban quản lý sẽ cấp cho em ạ",
  status: "PENDING",
  student_id: 1,
  index: 3
)

# Student.import_file File.open("#{Rails.root}/public/sv.xlsx")

