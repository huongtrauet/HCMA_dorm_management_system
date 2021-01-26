module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    session[:role] = user.class.name
    byebug
  end

  def current_user
    return unless session[:user_id]
    if session[:role] == 'Student'
      @current_user = Student.find_by id: session[:user_id]
    elsif session[:role] == 'Manager'
      @current_user = Manager.find_by id: session[:user_id]
    end
    return @current_user
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
