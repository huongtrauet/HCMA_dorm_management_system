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
    @student = Student.find(current_user[:id])
  end

  # POST /student_profiles or /student_profiles.json
  def create
    @student_profile = StudentProfile.new(student_profile_params.merge(student_id: current_user.id))
    if @student_profile.save
      redirect_to '/'
    end
  end

  def update
    if current_user.student_profile.update(student_profile_params)
      respond_to do |format|
        format.json {render json: {message: "Cập nhật thông tin cá nhân thành công!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: "Cập nhật thông tin cá nhân không thành công :("}, status: :bad_request}
      end
    end
  end

  def update_avatar
    if current_user.student_profile.update_attribute(:avatar, params[:avatar])
      respond_to do |format|
        format.json { render json: {message: "Cập nhật ảnh đại diện thành công!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Cập nhật ảnh đại diện thất bại :("}, status: :bad_request}
      end
    end
  end

  def reset_ava
    if current_user.student_profile.update_attribute(:avatar, nil)
      respond_to do |format|
        format.json { render json: {message: "Gỡ ảnh đại diện thành công!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Gỡ ảnh đại diện không thành công :("}, status: :bad_request}
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

  def reset_password
    if current_user&.authenticate reset_password_params[:current_password]
      if current_user.update(reset_password_params.except(:current_password))
        respond_to do |format|
          format.json { render json: {message: "Cập nhật mật khẩu thành công!"}, status: :ok}
        end
      else
        respond_to do |format|
          format.json { render json: {message: "Cập nhật mật khẩu khồng thành cồng :("}, status: :bad_request}
        end
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Mật khẩu hiện tại không chính xác"}, status: :bad_request}
      end
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
    def student_profile_params
      profile_params = params.require(:student).require(:student_profile_attributes).permit(:email, :class_name, :date_of_birth, :identity_card_number, :address, :phone_number, :gender)
      profile_params.merge!(class_name: nil) if profile_params[:class_name] == ""
      profile_params.merge!(date_of_birth: nil) if profile_params[:date_of_birth] == ""
      profile_params.merge!(identity_card_number: nil) if profile_params[:identity_card_number] == ""
      profile_params.merge!(address: nil) if profile_params[:address] == ""
      profile_params.merge!(phone_number: nil) if profile_params[:phone_number] == ""
      profile_params.merge!(gender: nil) if profile_params[:gender] == ""
      return profile_params
    end
    def reset_password_params
      params.permit(:current_password, :password, :password_confirmation)
    end
end
