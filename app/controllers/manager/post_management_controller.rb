class Manager::PostManagementController < ApplicationController
  layout 'manager_layout/manager'
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post_management = Post.new(post_params)
  end

  def create
    _params = post_params.merge(manager_id: 1, status: 'POSTED')
    @post = Post.new(_params)
    byebug
    if @post.save
      redirect_to manager_post_management_path
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:post][:id])
    byebug
    if @post.update(post_params)
      redirect_to manager_post_management_path
    else
      redirect_to manager_post_management_path
    end
  end

  def index
    @post_management = Post.new
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :writer_name, :id, :image)
  end
end
