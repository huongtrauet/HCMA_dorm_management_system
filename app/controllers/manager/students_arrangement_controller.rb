class Manager::StudentsArrangementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager

  def main
    
  end

  def remove_student_from_room
    @student = Student.find(params[:student_id])
    @room = Room.find(@student.room_id)
    message = "Xin lỗi, bạn đã bị chuyển ra khỏi phòng hiện tại. Mọi thắc vui lòng gặp trực tiếp ban quản lý tại phòng tiếp nhận sinh viên nhé!"
    @student.room.number_student = @student.room.number_student - 1
    if @student.update(room_id: 1, status: "PENDING")
      respond_to do |format|
        format.json {render json:{message: "Di chuyển học viên thành công!!!", room: @room}, status: :ok}
      end
      Notification.create(sender: current_user, receiver: @student, message: message, noti_type: "remove_student_from_room" )
    else
      respond_to do |format|
        format.json {render json:{message: "Xin lỗi, di chuyển học viên thất bại!!!"}, status: :bad_request}
      end
    end
  end

  def add_student_to_room
    # byebug
    @student = Student.find(params[:student_id])
    room_id = @student.room.id
    @room = Room.find(params[:room_id])
    message = "Bạn đã được thêm vào phòng #{@room.room_name}! Chúc bạn có những khoảng thời gian thật vui vẻ! "
    if @room.number_student < @room.max_number_student 
      if @student.update(room_id: @room.id, status: "ACTIVE")
        if @student.check_in_date == nil
          @student.update(check_in_date: DateTime.current.to_date)
        end
        respond_to do |format|
          format.json {render json:{message: "Thêm sinh viên vào phòng thành công!!", room: @room, room_id: room_id}, status: :ok }
        end
        Notification.create(sender: current_user, receiver: @student, message: message, noti_type: "add_student_to_room" )
      end
    else
      respond_to do |format|
        format.json {render json:{message: "Xin lỗi! Thêm sinh viên vào phòng thất bại :(", room_max_number_student: @room.max_number_student, room_student_number: @room.number_student},  status: :bad_request}
      end
    end
  end

  def search_rooms_arrangement
    if params[:q] 
      @rooms = Room.where.not(id: 1).ransack(room_name_or_room_type_cont: params[:q]).result
      if @rooms
        respond_to do |format|
          format.js {render partial: 'room_list_arrangement', locals: { rooms: @rooms, count: Post.all.count } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Không tìm thấy phòng nào :('}, status: :bad_request}
        end
      end
    elsif params[:q] == "" or params[:q] == nil
      @rooms = Room.where.not(id: 1)
      respond_to do |format|
        format.js {render partial: 'room_list_arrangement', locals: { rooms: @rooms, count: Post.all.count } } 
      end
    end
  end

  def search_pending_students_arrangement
    if params[:q] 
      @students = Student.all.ransack(name_or_student_id_number_cont: params[:q]).result
      if @students
        respond_to do |format|
          format.js {render partial: 'pending_student_list', locals: { pending_students: @students } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Không tìm thấy phòng nào :('}, status: :bad_request}
        end
      end
    elsif params[:q] == "" or params[:q] == nil
      @student = Student.all
      respond_to do |format|
        format.js {render partial: 'pending_student_list', locals: { pending_students: @students } } 
      end
    end
  end
end

  