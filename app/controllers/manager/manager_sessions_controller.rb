class Manager::ManagerSessionsController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :not_logged_in, only: [:create, :new]

  def new
  end
  def create
    manager = find_manager_by_email
    if manager != nil
      if manager&.authenticate params[:password]
        log_in manager
        # remember student
        params[:remember_me] == 'on' ? remember(manager) : forget(manager)
        redirect_back_or '/manager'
      else
        respond_to do |format|
          format.json {render json: {message: "Mật khẩu không chính xác!!"}, status: :bad_request}
        end
      end
    else
      respond_to do |format|
        format.json {render json: {message: "Tài khoản không tồn tại!!"}, status: :bad_request}
      end
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Đã đăng xuất"
    redirect_to manager_login_path
  end

  private

  def find_manager_by_email
    return Manager.find_by email: params[:email].downcase
  end

  def not_logged_in
    return if !logged_in_manager?

    redirect_to "/manager/"
  end
end
