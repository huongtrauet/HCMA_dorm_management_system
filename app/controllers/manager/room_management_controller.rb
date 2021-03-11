class Manager::RoomManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @room_service_charges = ServiceCharge.where(room_id: params[:id]).order("year DESC").order("month DESC")


  end

  def create
    @room = Room.new(room_params)
    if @room.save
      respond_to do |format|
        format.js {render partial: 'room_item', content_type: 'text/html', locals: { room: @room, index: Room.all.count} } 
      end
    else
      respond_to do |format|
        format.json { render json: @room.errors, status: :bad_request }

      end
    end
  end

  def check_duplicate_room
    @room = Room.find_by(room_name: params[:room_name])
    if @room
      respond_to do |format|
        format.json { render json: {is_duplicate:true},  status: :bad_request } 
      end
    else
      respond_to do |format|
        format.json { render json: {is_duplicate:false} } 
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_type, :max_number_student)
  end

end
