class Manager::StudentsArrangementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token

  def main
    
  end

  def remove_student_from_room
    @student = Student.find(params[:student_id])
    @room = Room.find(@student.room_id)
    @room.update(number_student: @room.number_student - 1)
    message = "You have been removed from your room, any questions please contact the management directly"
    if @student.update(room_id: 1, status: "PENDING")
      respond_to do |format|
        format.json {render json:{message: "Remove student successfully!!!"}, status: :ok}
      end
      Notification.create(sender: current_user, receiver: @student, message: message )
      # create_student_notification @student, message
      # Notification.create(message: "You have been removed from your room, any questions please contact the management directly", sender: current_user, receiver: @student )

    else
      respond_to do |format|
        format.json {render json:{message: "Remove student fail!!!"}, status: :bad_request}
      end
    end
  end

  def add_student_to_room
    # byebug
    @student = Student.find(params[:student_id])
    @room = Room.find(params[:room_id])
    message = "You have been added to room #{@room.room_name}"
    if @room.number_student < @room.max_number_student 
      if @room.update(number_student: @room.number_student + 1) && @student.update(room_id: @room.id, status: "ACTIVE")
        # create_student_notification @student
        respond_to do |format|
          format.json {render json:{message: "Add student to room successfully!!"}, status: :ok }
        end
        Notification.create(sender: current_user, receiver: @student, message: message )
      end
    else
      byebug
      respond_to do |format|
        format.json {render json:{message: "Add student to room fail!!", room_max_number_student: @room.max_number_student, room_student_number: @room.number_student},  status: :bad_request}
      end
    end
  end

  def search_rooms_arrangement
    if params[:q] 
      @rooms = Room.where.not(id: 1).ransack(room_name_or_status_cont: params[:q]).result
      if @rooms
        respond_to do |format|
          format.js {render partial: 'room_list_arrangement', locals: { rooms: @rooms, count: Post.all.count } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Room not found'}, status: :bad_request}
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
      @students = Student.all.ransack(name_cont: params[:q]).result
      if @students
        respond_to do |format|
          format.js {render partial: 'pending_student_list', locals: { pending_students: @students } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Room not found'}, status: :bad_request}
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

  