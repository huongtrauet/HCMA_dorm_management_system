class Manager::StudentManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def index
    @students = Student.all
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    byebug
    if(student_create_params[:student_id_number_confirm] == student_create_params[:student_id_number])
      student_id_number = student_create_params[:student_id_number]
      new_params = student_create_params.merge(password: student_id_number, password_confirmation: student_id_number).except(:student_id_number_confirm)
      @student = Student.new(new_params)
      @student.student_profile = StudentProfile.new(email:"#{@student.student_id_number}@gmail.com", identity_card_number: @student.student_id_number)
    else
      redirect_to manager_student_management_path
    end
    if @student.save
      respond_to do |format|
        format.js {render partial: 'line_student', locals: { student: @student, index: Student.all.count } } 
      end
    elsif
      respond_to do |format|
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_room_member
    @room = Room.find(params[:room_id])
    if(student_create_params[:student_id_number_confirm] == student_create_params[:student_id_number])
      student_id_number = student_create_params[:student_id_number]
      new_params = student_create_params.merge(password: student_id_number, password_confirmation: student_id_number).except(:student_id_number_confirm)
      @student = Student.new(new_params)
      @student.student_profile = StudentProfile.new(email:"#{@student.student_id_number}@gmail.com", identity_card_number: @student.student_id_number)
    else
      redirect_to manager_student_management_path
    end
    if @student.save
      respond_to do |format|
        format.js {render partial: '/manager/room_management/line_student_member', locals: { member: @student, index: @room.students.count } } 
      end
    elsif
      respond_to do |format|
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @student = Student.find_by(params[:id])
    @student_profile = @student.student_profile
    if @student
      respond_to do |format|
        format.json {render json: {student: @student, student_profile: @student_profile}}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Coundn't find"}, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to manager_student_management_path
    else
      redirect_to manager_student_management_path
    end
  end

  def destroy
    @student = Student.find(params[:id])
    if @student.destroy
      redirect_to manager_student_management_path
    else
      redirect_to manager_student_management_path
    end
  end

  private

  def student_params
    params.require(:student).permit(:student_id_number, :check_in_date, :check_out_date, student_profile_attributes: [:email, :class_name, :name, :date_of_birth, :identity_card_number, :address, :phone_number, :gender, :avatar])
  end

  def student_create_params
    params.permit(:student_id_number, :student_id_number_confirm, :check_in_date, :check_out_date, :name, :room_id)
  end

end
