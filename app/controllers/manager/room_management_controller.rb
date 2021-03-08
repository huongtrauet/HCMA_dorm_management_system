class Manager::RoomManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      byebug
      respond_to do |format|
        format.js {render partial: 'room_item', content_type: 'text/html', locals: { room: @room, index: Room.all.count} } 
      end
    else
      redirect_to manager_student_management_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_type, :max_number_student)
  end

end
