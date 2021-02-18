class Manager::RoomManagementController < ApplicationController
  layout 'manager_layout/manager'
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end
end
