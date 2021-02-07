class Student::StudentSessionsController < StudentMainController
  def new
  end
  def create
    student = find_student_by_student_id_number
    if student&.authenticate params[:student_session][:password]
      flash[:success] = t ".login_success"
      log_in student
      params[:student_session][:remember_me] == '1' ? remember(student) : forget(student)
      # remember student
      redirect_to student_requests_path
    else
      flash[:error] = t ".invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".logout_success"
    redirect_to student_login_path
  end

  private

  def find_student_by_student_id_number
    return Student.find_by student_id_number: params[:student_session][:student_id_number].downcase
  end
end
