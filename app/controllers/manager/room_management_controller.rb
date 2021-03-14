class Manager::RoomManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def index
    byebug
    @rooms = Room.all
    respond_to do |format|
      # format.json {render json: {rooms: @rooms}}
      format.js {render partial: 'room_list_arrangement', locals: { rooms: @rooms, count: Post.all.count } } 
    end
  end

  def show
    @room = Room.find(params[:id])
    @room_members = @room.students.order("name DESC")

  end

  def show_room_members
    @room = Room.find(params[:room_id])
    @room_members = @room.students.order("name DESC")
  end

  def show_room_facilities
    @room = Room.find(params[:room_id])
  end

  def show_room_service_charges
    @room = Room.find(params[:room_id])
    @room_service_charges = @room.service_charges.order("year DESC").order("month DESC")
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

  def create_room_facility
        
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_type, :max_number_student)
  end

end
