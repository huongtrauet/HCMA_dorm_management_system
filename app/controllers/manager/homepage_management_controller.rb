class Manager::HomepageManagementController < ManagerMainController
  layout 'manager_layout/manager'
  def index
    @posts = Post.all.where(status: "POSTED").order('created_at DESC').page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
  end
end
