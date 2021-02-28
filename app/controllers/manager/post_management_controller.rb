class Manager::PostManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post_management = Post.new(post_params)
  end

  def create
    _params = post_params.merge(manager_id: 1, status: 'POSTED')
    @post = Post.new(_params)
    if @post.save
      redirect_to manager_post_management_path
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:post][:id])
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

  def change_post_status
    @post = Post.find_by_id(params[:id])
    if @post.status == "POSTED"
      @post.update_attribute(:status, 'DELETED')
      respond_to do |format|
        format.html
        format.json {render json: {message: "deleted sucessfully!!!", status: @post.status}}
      end
    elsif @post.status == "DELETED"
      @post.update_attribute(:status, 'POSTED')
      respond_to do |format|
        format.html
        format.json {render json: {message: "restored sucessfully!!!", status: @post.status}}
      end
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :content, :writer_name, :id, {images: []} )
  end
end
