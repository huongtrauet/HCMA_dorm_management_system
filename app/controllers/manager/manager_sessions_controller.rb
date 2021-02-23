class Manager::ManagerSessionsController < ManagerMainController
  def new
  end
  def create
    manager = find_manager_by_email
    if manager&.authenticate params[:manager_session][:password]
      flash[:success] = t ".login_success"
      log_in manager
      params[:manager_session][:remember_me] == '1' ? remember(manager) : forget(manager)
      # remember student
      redirect_to manager_students_arrangement_path
    else
      flash[:error] = t ".invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".logout_success"
    redirect_to manager_login_path
  end

  private

  def find_manager_by_email
    return Manager.find_by email: params[:manager_session][:email].downcase
  end
end
