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
        format.json {render json: {message: 'Đường dẫn thay đổi mật khẩu đã được gửi tới email của bạn! Vui lòng kiểm tra email!'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Mã học viên không tồn tại'}, status: :bad_request}
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
        format.json {render json: {message: 'Mật khẩu không được để trống'}, status: :bad_request}
      end
    elsif @student.update user_params.merge reset_digest: nil
      respond_to do |format|
        format.json {render json: {message: 'Đổi mật khẩu thành công! Đăng nhập lại tại đây!'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Đổi mật khấu không thành công :('}, status: :bad_request}
      end
    end
  end

  def user_params
    return params.permit(:password, :password_confirmation)
  end

  def valid_student
    @student = Student.find_by(student_id_number: params[:student_id_number])
    unless @student&.authenticated?(:reset, params[:token]) #check reset_token co khop voi reset_token_digest trong db khong
      respond_to do |format|
        format.json {render json: {message: 'Đường link thay đổi mật khẩu này không hợp lệ, vui lòng thực hiện lại'}, status: :bad_request}
      end
    end
  end

  def check_expiration
    return unless @student.password_reset_expired?
    respond_to do |format|
      format.json {render json: {message: 'Đường link thay đổi mật khẩu này đã hết hạn! Vui lòng thực hiện lại'}, status: :bad_request}
    end
  end
end