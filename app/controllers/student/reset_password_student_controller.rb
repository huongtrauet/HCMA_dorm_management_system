class Student::ResetPasswordStudentController < StudentMainController
  layout 'student_layout/student'
  skip_before_action :verify_authenticity_token
  before_action :valid_student, :check_expiration, only: %i(update_student_password)
  
  def reset_student_password
    @student = Student.find_by(student_id_number: params[:student_id_number])
    if @student
      @student.create_reset_digest
      @student.send_password_reset_email
      log_out if logged_in?
      respond_to do |format|
        format.json {render json: {message: 'Đường dẫn thay đổi mật khẩu đã được gửi tới email của bạn'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Đã xảy ra lỗi khi gửi email'}, status: :bad_request}
      end
    end
  end

  def edit_student_password
    log_out if logged_in?
  end

  def update_student_password
    @student = Student.find_by(student_id_number: params[:student_id_number])
    if params[:password].blank?
      respond_to do |format|
        format.json {render json: {message: 'Password is required'}, status: :bad_request}
      end
    elsif @student.update user_params.merge reset_digest: nil
      respond_to do |format|
        format.json {render json: {message: 'Reset password successfully'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Reset password failed'}, status: :bad_request}
      end
    end
  end

  def user_params
    return params.permit(:password, :password_confirmation)
  end

  def valid_student
    @student = Student.find_by(student_id_number: params[:student_id_number])
    unless @student&.authenticated?(:reset, params[:token])
      respond_to do |format|
        format.json {render json: {message: 'Token is invalid'}, status: :bad_request}
      end
    end
  end

  def check_expiration
    return unless @student.password_reset_expired?
    respond_to do |format|
      format.json {render json: {message: 'Reset password token is expired'}, status: :bad_request}
    end
  end
end