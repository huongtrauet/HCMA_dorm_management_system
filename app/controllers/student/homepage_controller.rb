class Student::HomepageController < StudentMainController
  layout 'student_layout/student'
  before_action :logged_in_student
  def index
    @posts = Post.all.where(status: "POSTED").order('created_at DESC').page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
  end
end
