class Student::StudentProfilesController < StudentMainController
  layout 'student_layout/student'
  before_action :logged_in_student
  skip_before_action :verify_authenticity_token

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
    @student = Student.find(params[:id])
  end

  # POST /student_profiles or /student_profiles.json
  def create
    @student_profile = StudentProfile.new(student_profile_params.merge(student_id: current_user.id))
    if @student_profile.save
      redirect_to '/'
    end
  end

  def update
    if current_user.student_profile.update(student_params[:student_profile_attributes])
      respond_to do |format|
        format.json {render json: {message: "Update your profile successfully!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: "Update your profile failed!!"}, status: :bad_request}
      end
    end
  end

  def update_avatar
    current_user.student_profile.update_attribute(:avatar, params[:avatar])
    respond_to do |format|
      format.json { render json: {message: "Update avatar successfully!!"}, status: :ok}
    end
  end

  def reset_ava
    if current_user.student_profile.update_attribute(:avatar, nil)
      respond_to do |format|
        format.json { render json: {message: "Reset avatar successfully!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Reset avatar failed!!"}, status: :bad_request}
      end
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
    def student_params
      params.require(:student).permit(student_profile_attributes: [:email, :class_name, :date_of_birth, :identity_card_number, :address, :phone_number, :gender])
    end
end
