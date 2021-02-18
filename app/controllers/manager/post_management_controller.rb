class Manager::PostManagementController < ApplicationController
  layout 'manager_layout/manager'
  def index
    @post = Post.new
  end
end
