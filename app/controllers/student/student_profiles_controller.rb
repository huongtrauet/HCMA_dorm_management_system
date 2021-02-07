class Student::StudentProfilesController < StudentMainController
  layout 'student_layout/student'
  before_action :set_student_profile, only: %i[ show edit update destroy ]
  before_action :logged_in_student

  # GET /student_profiles or /student_profiles.json
  def index
    @student_profiles = StudentProfile.all
  end

  # GET /student_profiles/1 or /student_profiles/1.json
  def show
    @student_profile = StudentProfile.find(16)
  end

  # GET /student_profiles/new
  def new
    @student_profile = StudentProfile.new
  end

  # GET /student_profiles/1/edit
  def edit
    @student_profile = StudentProfile.new
  end

  # POST /student_profiles or /student_profiles.json
  def create
    @student_profile = StudentProfile.new(student_profile_params.merge(student_id: current_user.id))
    if @student_profile.save
      redirect_to '/'
    end
  end

  def update
    @student = current_user
    if @student.update(student_profile_params)
      redirect_to "/"
    end
  end

  # DELETE /student_profiles/1 or /student_profiles/1.json
  def destroy
    @student_profile.destroy
    respond_to do |format|
      format.html { redirect_to student_profiles_url, notice: "Student profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_profile
      @student_profile = StudentProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_profile_params
      # params.fetch(:student_profile, {})
      params.require(:student_profile).permit :email, :class_name, :name, :date_of_birth, :identity_card_number, :address, :phone_number, :gender
    end
end
