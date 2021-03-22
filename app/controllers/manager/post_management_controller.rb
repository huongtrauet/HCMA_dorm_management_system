class Manager::PostManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json {render json: {object: @post}}
    end
  end

  def new
    @post_management = Post.new(post_params)
  end

  def create
    # byebug
    _params = create_post_params.merge(manager_id: 1, status: 'POSTED')
    @post = Post.new(_params)
    @post_management = Post.new
    if @post.save
      respond_to do |format|
        format.js {render partial: 'list_post_item', locals: { post: @post, index: Post.all.count, post_management: @post_management } } 
      end
      # redirect_to manager_post_management_path
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

  def find_post
    if params[:q] 
      @posts = Post.all.ransack(title_or_status_or_writer_name_cont: params[:q]).result
      if @posts
        respond_to do |format|
          format.js {render partial: 'post_table', locals: { posts: @posts } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Room not found'}, status: :bad_request}
        end
      end
    elsif params[:q] == "" or params[:q] == nil
      @posts = Post.all
      respond_to do |format|
        format.js {render partial: 'post_table', locals: { posts: @posts } } 
      end
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :content, :writer_name, :id )
  end

  def create_post_params
    params.permit(:title, :content, :writer_name, {images: []})
  end
end
