class Manager::StudentManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager

  def index
    @students = Student.all.order('created_at DESC').page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def edit
    @student = Student.find(params[:id])
    @rooms = Room.all
  end

  def create
    # byebug
    if(student_create_params[:student_id_number_confirm] == student_create_params[:student_id_number])
      student_id_number = student_create_params[:student_id_number]
      new_params = student_create_params.merge(password: student_id_number, password_confirmation: student_id_number, channel: generate_channel).except(:student_id_number_confirm)
      @student = Student.new(new_params)
      @student.student_profile = StudentProfile.new(email:"#{@student.student_id_number}@gmail.com", name: @student.name)
    else
      respond_to do |format|
        format.json { render json: { message: 'Nhập lại mã học viên không khớp!' } }
      end
    end
    if @student.save
      respond_to do |format|
        format.json {render json: {message: 'Tạo tài khoản học viên thành công!!!'}, status: :ok } 
      end
    elsif
      respond_to do |format|
        format.json { render json: {message: 'Tạo tài khoản không thành công :('}, status: :unprocessable_entity }
      end
    end
  end

  def create_room_member
    @room = Room.find(params[:room_id])
    if(create_room_member_params[:create_student_id_number_confirm] == create_room_member_params[:create_student_id_number])
      student_id_number = create_room_member_params[:create_student_id_number]
      new_params = create_room_member_params.merge(password: student_id_number, password_confirmation: student_id_number, student_id_number: student_id_number, channel: generate_channel).except(:create_student_id_number_confirm, :create_student_id_number)
      @student = Student.new(new_params.merge(status: 'ACTIVE'))
      @student.student_profile = StudentProfile.new(email:"#{@student.student_id_number}@gmail.com", identity_card_number: @student.student_id_number, name: @student.name)
    else
      respond_to do |format|
        format.json { render json: { message: "Xin lỗi, tạo tài khoản học viên không thành công :(" }, status: :bad_request }
      end
    end

    if @student.save
      respond_to do |format|
        format.json { render json: { message: "Tạo tài khoản học viên thành công!!" }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Xin lỗi, taok tài khoản học viên không thành công :(" }, status: :bad_request }
      end
    end
  end

  def show
    @student = Student.find(params[:id])
    @rooms = Room.all
    @student_profile = @student.student_profile
    if @student
      respond_to do |format|
        format.json {render json: {student: @student, student_profile: @student_profile, rooms: @rooms}}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Không tìm thấy :("}, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params.merge(name: params[:student][:student_profile_attributes][:name]))
      if @student.room.id != 1 and @student.status != 'ACTIVE'
        @student.update_attribute(:status, 'ACTIVE')
      elsif @student.room.id == 1 and @student.status == 'ACTIVE'
        @student.update_attribute(:status, 'PENDING')
      end
      respond_to do |format|
        format.json { render json: { message: "Cập nhật thông tin cá nhân học viên thành công!" }, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Cập nhật thông tin cá nhân học viên thất bại :(" }, status: :bad_request}
      end
    end
  end

  def destroy
    @student = Student.find(params[:id])
    room_id = @student.room.id
    if @student.destroy
      @room = Room.find(room_id)
      respond_to do |format|
        format.json { render json: {room: @room, message: "Xoá tài khoản học viên thành công!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Xoá tài khoản học viên không thành công :("}, status: :bad_request}
      end
    end
  end

  def find_pending_student
    # @room_service_charges = ServiceCharge.where(room_id: params[:id]).order("year DESC").order("month DESC")
    @pending_students = Student.where(status: "PENDING").order("name ASC")
    respond_to do |format|
      format.js {render partial: '/manager/students_arrangement/pending_student_list', locals: { pending_students: @pending_students } } 
    end
  end

  def search_student
    if params[:status] == "PENDING" or params[:status] == "ACTIVE"
      @students = Student.all.where(status: params[:status]).order("name ASC")
      if params[:q] == "" or params[:q] == nil or params[:q] == "undefined"
        respond_to do |format|
          format.js {render partial: 'student_table', locals: { students: @students, is_full: false } } 
        end
      elsif params[:q] 
        @students = @students.ransack(name_or_student_id_number_or_status_cont: params[:q]).result.order("name ASC")
        if @students
          respond_to do |format|
            format.js {render partial: 'student_table', locals: { students: @students, is_full: false } } 
          end
        else
          respond_to do |format|
            format.json {render json: {message: 'Không tìm thấy phòng nào :('}, status: :bad_request}
          end
        end
      end
    else
      @students = Student.all.order("name ASC")
      if params[:q] == "" or params[:q] == nil
        respond_to do |format|
          format.json {render json: {is_all: true}, status: :bad_request} 
        end
      elsif params[:q] 
        @students = @students.ransack(name_or_student_id_number_or_status_cont: params[:q]).result.order("name ASC")
        if @students
          respond_to do |format|
            format.js {render partial: 'student_table', locals: { students: @students, is_full: false } } 
          end
        else
          respond_to do |format|
            format.json {render json: {message: 'Không tìm thấy phòng nào :('}, status: :bad_request}
          end
        end
      end
    end
  end

  def reset_ava
    @student = Student.find(params[:id])
    if @student.student_profile.update_attribute(:avatar, nil)
      respond_to do |format|
        format.json { render json: {message: "Xoá ảnh đại diện thành công!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Xin lỗi, xoá ảnh đại diện không thành công :("}, status: :bad_request}
      end
    end
  end

  def update_avatar
    @student = Student.find(params[:id])
    if @student.student_profile.update_attribute(:avatar, params[:avatar])
      respond_to do |format|
        format.json { render json: {message: "Cập nhật ảnh đại diện thành công!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Cập nhật ảnh đại diện không thành công :("}, status: :bad_request}
      end
    end
  end

  def check_duplicate_student
    @student = Student.find_by(student_id_number: params[:student_id_number])
    if @student
      respond_to do |format|
        format.json { render json: {is_duplicate:true},  status: :bad_request } 
      end
    else
      respond_to do |format|
        format.json { render json: {is_duplicate:false} } 
      end
    end
  end

  # def check_duplicate_informations
  #   byebug
  #   is_duplicate_student_id_number = false
  #   is_duplicate_email = false
  #   is_duplicate_identity = false
  #   if Student.find_by(student_id_number: params[:student_id_number])
  #     is_duplicate_student_id_number = true
  #   end
  #   if Student.find_by(email: params[:email])
  #     is_duplicate_email = true
  #   end
  #   if Student.find_by(identity_card_number: params[:identity_card_number])
  #     is_duplicate_identity = true
  #   end

  #   if is_duplicate_student_id_number == false and is_duplicate_email == false and is_duplicate_identity == false
  #     respond_to do |format|
  #       format.json { render json: {is_duplicate: false},  status: :ok } 
  #     end
  #   elsif is_duplicate_student_id_number == true || is_duplicate_email == true || is_duplicate_identity == true
  #     respond_to do |format|
  #       format.json { render json: {is_duplicate_student_id_number: is_duplicate_student_id_number, is_duplicate_email: is_duplicate_email, is_duplicate_identity: is_duplicate_identity, is_duplicate: true },  status: :ok } 
  #     end
  #   else
  #     respond_to do |format|
  #       format.json { render json: {message: "Kiểm tra trùng lặp thông tin gặp chút vấn đề!"},  status: :bad_request } 
  #     end
  #   end
  # end

  private

  def student_params
    profile_params = params.require(:student).permit(:student_id_number, :check_in_date, :check_out_date, :room_id, :extended_time, student_profile_attributes: [:email, :class_name, :name, :date_of_birth, :identity_card_number, :address, :phone_number, :gender])
      profile_params.require(:student_profile_attributes).merge!(class_name: nil) if profile_params[:student_profile_attributes][:class_name] == ""
      profile_params.require(:student_profile_attributes).merge!(date_of_birth: nil) if profile_params[:student_profile_attributes][:date_of_birth] == ""
      profile_params.require(:student_profile_attributes).merge!(identity_card_number: nil) if profile_params[:student_profile_attributes][:identity_card_number] == ""
      profile_params.require(:student_profile_attributes).merge!(address: nil) if profile_params[:student_profile_attributes][:address] == ""
      profile_params.require(:student_profile_attributes).merge!(phone_number: nil) if profile_params[:student_profile_attributes][:phone_number] == ""
      profile_params.require(:student_profile_attributes).merge!(gender: nil) if profile_params[:student_profile_attributes][:gender] == ""
      return profile_params
  end

  def student_create_params
    params.permit(:student_id_number, :student_id_number_confirm, :check_in_date, :check_out_date, :name, :room_id)
  end

  def create_room_member_params
    params.permit(:create_student_id_number, :create_student_id_number_confirm, :check_in_date, :check_out_date, :name, :room_id)
  end

  def generate_channel
    Time.now.to_i
  end
end
