class Manager::ResetPasswordManagerController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :valid_manager, :check_expiration, only: %i(update_manager_password)
  
  def reset_manager_password
    @manager = Manager.first
    if @manager
      @manager.create_reset_digest
      @manager.send_password_reset_email
      log_out if logged_in?
      respond_to do |format|
        format.json {render json: {message: 'Hệ thống đã gửi email đổi mật khẩu vào email bạn đã đăng ký. Vui lòng kiểm tra email!'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Không thể gửi email đổi mật khẩu, vui lòng kiểm tra lại sau :('}, status: :bad_request}
      end
    end
  end

  def edit_manager_password
    log_out if logged_in?
  end

  def update_manager_password
    @manager = Manager.first
    if params[:password].blank?
      respond_to do |format|
        format.json {render json: {message: 'Mật khẩu không được để trống!'}, status: :bad_request}
      end
    elsif @manager.update user_params.merge reset_digest: nil
      log_in @manager
      respond_to do |format|
        format.json {render json: {message: 'Đổi mật khẩu thành công!'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Đổi mật khẩu thất bại :('}, status: :bad_request}
      end
    end
  end

  def user_params
    return params.permit(:password, :password_confirmation)
  end

  def valid_manager
    @manager = Manager.first
    unless @manager&.authenticated?(:reset, params[:token])
      respond_to do |format|
        format.json {render json: {message: 'Đường link thay đổi mật khẩu này không hợp lệ! Vui lòng thực hiện lại!'}, status: :bad_request}
      end
    end
  end

  def check_expiration
    return unless @manager.password_reset_expired? #nếu chưa hết hạn
    respond_to do |format|
      format.json {render json: {message: 'Đường link thay đổi mật khẩu này đã hết hạn! Vui lòng thực hiện lại!'}, status: :bad_request}
    end
  end
end