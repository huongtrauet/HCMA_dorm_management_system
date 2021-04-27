class UserMailer < ApplicationMailer
  def password_reset user
    @user = user
    if @user.class.name == 'Student'
      @email = user.student_profile.email
    else
      @email = user.email
    end
    mail to: @email, subject: "reset password"
  end
end
