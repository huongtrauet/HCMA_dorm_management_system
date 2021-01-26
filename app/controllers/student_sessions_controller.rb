class StudentSessionsController < ApplicationController
  def new
  end
  def create
    student = find_student_by_student_id_number
    if student&.authenticate params[:student_session][:password]
      flash[:success] = t ".login_success"
      log_in student
      redirect_to root_url
    else
      flash[:error] = t ".invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".logout_success"
    redirect_to root_url
  end

  private

  def find_student_by_student_id_number
    Student.find_by student_id_number: params[:student_session][:student_id_number].downcase
  end
end
