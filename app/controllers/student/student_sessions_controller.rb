class Student::StudentSessionsController < StudentMainController
  layout 'student_layout/student'
  skip_before_action :verify_authenticity_token
  def new
  end
  def create
    # byebug
    student = find_student_by_student_id_number
    if student&.authenticate params[:password]
      flash[:success] = "Đăng nhập thành công"
      log_in student
      params[:remember_me] == 'on' ? remember(student) : forget(student)
      respond_to do |format|
        format.json {render json: {message: "Đăng nhập thành công!!"}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: "Mật khẩu không chính xác!!"}, status: :bad_request}
      end
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".logout_success"
    redirect_to student_login_path
  end

  private

  def find_student_by_student_id_number
    return Student.find_by student_id_number: params[:student_id_number].downcase
  end
end
