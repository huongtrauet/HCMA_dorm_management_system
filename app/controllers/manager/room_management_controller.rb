class Manager::RoomManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  # all room in room_management
  def index
    @rooms = Room.where.not(id: 1)
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(update_room_params)
      format.json { render json: { message: "Update success" }, status: :ok}
    else
      format.json { render json: { message: "Update fail" }, status: :bad_request}
    end
  end

  def show_room_members
    @room = Room.find(params[:room_id])
    @room_members = @room.students.order("name DESC")
    location
  end

  def show_room_facilities
    @room = Room.find(params[:room_id])
  end

  def show_room_service_charges
    @room = Room.find(params[:room_id])
    @room_service_charges = @room.service_charges.order("year DESC").order("month DESC")
  end

  def show_room_informations
    @room = Room.find(params[:room_id])
    # @room_service_charges = @room.service_charges.order("year DESC").order("month DESC")
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

  def find_room
    if params[:q] 
      @rooms = Room.where.not(id: 1).ransack(room_name_or_status_or_room_type_cont: params[:q]).result
      if @rooms
        respond_to do |format|
          format.js {render partial: 'room_table', locals: { rooms: @rooms } } 
        end
      else
        respond_to do |format|
          format.json {render json: {message: 'Room not found'}, status: :bad_request}
        end
      end
    elsif params[:q] == "" or params[:q] == nil
      @rooms = Room.where.not(id: 1)
      respond_to do |format|
        format.js {render partial: 'room_table', locals: { rooms: @rooms } } 
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_type, :max_number_student)
  end

  def update_room_params
    params.permit(:room_name, :room_type, :number_student, :max_number_student, :gender)
  end

end
