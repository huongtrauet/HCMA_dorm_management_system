class Manager::StudentManagementController < ApplicationController
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
    if(student_create_params[:student_id_number_confirm] == student_create_params[:student_id_number])
      student_id_number = student_create_params[:student_id_number]
      new_params = student_create_params.merge(password: student_id_number, password_confirmation: student_id_number, channel: generate_channel).except(:student_id_number_confirm)
      @student = Student.new(new_params)
      @student.student_profile = StudentProfile.new(email:"#{@student.student_id_number}@gmail.com", name: @student.name)
    else
      redirect_to manager_student_management_path
    end
    if @student.save
      respond_to do |format|
        format.json {render json: {message: 'Created student account successfully!!!'}, status: :ok } 
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
      new_params = student_create_params.merge(password: student_id_number, password_confirmation: student_id_number, channel: generate_channel).except(:student_id_number_confirm)
      @student = Student.new(new_params)
      @student.student_profile = StudentProfile.new(email:"#{@student.student_id_number}@gmail.com", identity_card_number: @student.student_id_number, name: @student.name)
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
    @student = Student.find(params[:id])
    @rooms = Room.all
    @student_profile = @student.student_profile
    if @student
      respond_to do |format|
        format.json {render json: {student: @student, student_profile: @student_profile, rooms: @rooms}}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Coundn't find"}, status: :unprocessable_entity }
      end
    end
  end

  def update
    byebug
    @student = Student.find(params[:id])
    if @student.update(student_params.merge(name: params[:student][:student_profile_attributes][:name]))
      # flash[:success] = "Update success!!"
      url = cookies[:forwarding_url]
      cookies.delete(:forwarding_url)
      redirect_to url
    else
      url = cookies[:forwarding_url]
      cookies.delete(:forwarding_url)
      redirect_to url
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

  def find_pending_student
    # @room_service_charges = ServiceCharge.where(room_id: params[:id]).order("year DESC").order("month DESC")
    @pending_students = Student.where(status: "PENDING").order("name DESC")
    respond_to do |format|
      format.js {render partial: '/manager/students_arrangement/pending_student_list', locals: { pending_students: @pending_students } } 
    end
  end

  def search_student
    if params[:q] == "" or params[:q] == nil
      respond_to do |format|
        format.json {render json: {is_all: true}, status: :bad_request} 
      end
    elsif params[:q] 
      @students = Student.all.ransack(name_or_student_id_number_or_status_cont: params[:q]).result
      if @students
        respond_to do |format|
          format.js {render partial: 'student_table', locals: { students: @students, is_full: false } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Room not found'}, status: :bad_request}
        end
      end
    end
  end

  def reset_ava
    @student = Student.find(params[:id])
    if @student.student_profile.update_attribute(:avatar, nil)
      respond_to do |format|
        format.json { render json: {message: "Reset avatar successfully!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Reset avatar failed!!"}, status: :bad_request}
      end
    end
  end

  def update_avatar
    @student = Student.find(params[:id])
    if @student.student_profile.update_attribute(:avatar, params[:avatar])
      respond_to do |format|
        format.json { render json: {message: "Update avatar successfully!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Update avatar failed!!"}, status: :bad_request}
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

  private

  def student_params
    profile_params = params.require(:student).permit(:student_id_number, :check_in_date, :check_out_date, :room_id, :extended_time, student_profile_attributes: [:email, :class_name, :name, :date_of_birth, :identity_card_number, :address, :phone_number, :gender, :avatar])
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

  def generate_channel
    Time.now.to_i
  end
end
