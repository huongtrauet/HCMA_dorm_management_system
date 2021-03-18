class Manager::RoomManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  # all room in room_management
  def index
    @rooms = Room.where.not(id: 1)
  end

  # search room in student arrangement main
  # def search_rooms_arrangement
  #   if params[:q] 
  #     @rooms = Room.where.not(id: 1).ransack(room_name_or_status_cont: params[:q]).result
  #     if @rooms
  #       respond_to do |format|
  #         format.js {render partial: 'room_list_arrangement', locals: { rooms: @rooms, count: Post.all.count } } 
  #       end
  #     else
  #       respond_to do |format|
  #         format.json {render json: {message: 'Room not found'}, status: :bad_request}
  #       end
  #     end
  #   elsif params[:q] == "" or params[:q] == nil
  #     @rooms = Room.where.not(id: 1)
  #     respond_to do |format|
  #       format.js {render partial: 'room_list_arrangement', locals: { rooms: @rooms, count: Post.all.count } } 
  #     end
  #   end
  # end

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

  def active_room
    @room = Room.find_by(id: params[:room_id])
    if @room
      respond_to do |format|
        format.js {render partial: 'room_active', content_type: 'text/html', locals: { room: @room} } 
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_type, :max_number_student)
  end

end
