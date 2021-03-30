class Student::RoomsController < StudentMainController
  layout 'student_layout/student'
  before_action :set_room, only: %i[ show edit update destroy ]

  def room_member
    @room =current_user.room
    if @room.id != 1
      @members = Student.all.where(room_id: @room.id)
    else
      @members = nil
      # @service_charges = ServiceCharge.new
    end  
  end

  def room_service_charge
    @room = current_user.room
    @service_charges = ServiceCharge.all.where(room_id: current_user.room.id).order("year DESC").order("month DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def show_member
    @student = Student.find(params[:id])
    @student_profile = @student.student_profile
    respond_to do |format|
      format.json {render json: {student: @student, student_profile: @student_profile}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = current_user.room
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:room_name, :max_number_student)
    end
end
