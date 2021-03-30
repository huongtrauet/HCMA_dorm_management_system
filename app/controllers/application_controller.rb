class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_student
    return if logged_in?

    location
    flash[:error] = t "users.new.login"
    redirect_to student_login_url
  end

  def logged_in_manager
    return if logged_in?

    location
    flash[:error] = t "users.new.login"
    redirect_to manager_login_url
  end

end
