class Manager::RoomManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager
  
  # all room in room_management
  def index
    @rooms = Room.where.not(id: 1).order('order_name ASC').page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(update_room_params)
      order = @room.room_name.split('_')[0][1..-1].concat(@room.room_name.split('_')[1])
      @room.update_attribute(:order_name, order.to_i)
      respond_to do |format|
        format.json { render json: { message: "Cập nhật thành công!" }, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Cập nhật thất bại :(" }, status: :bad_request}
      end
    end
  end

  def show_room_members
    @room = Room.find(params[:room_id])
    @room_members = @room.students.order('first_name ASC').order('last_name ASC')
    location
  end

  def show_room_facilities
    @room = Room.find(params[:room_id])
    @facilities = @room.facilities.all.order("created_at DESC")
  end

  def show_room_service_charges
    @room = Room.find(params[:room_id])
    @room_service_charges = @room.service_charges.order("year DESC").order("month DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def show_room_informations
    @room = Room.find(params[:room_id])
    # @room_service_charges = @room.service_charges.order("year DESC").order("month DESC")
  end


  def create
    building_name = room_params[:room_name].split("_")[0]
    building = Building.find_by(name: building_name)
    if building
      @room = Room.new(room_params.merge(building_id: building.id))
    else 
      new_building = Building.create(name: building_name)
      @room = Room.new(room_params.merge(building_id: new_building.id))
    end

    if @room.save
      respond_to do |format|
        format.json { render json: { message: 'Tạo mới một phòng thành công!'}, status: :ok}
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Tạo mới phòng không thành công :('}, status: :bad_request}
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
    if params[:status] == "FULL" or params[:status] == "UNFILLED" or params[:status] == "PENDING"
      @rooms = Room.all.where.not(id: 1).where(status: params[:status]).order('order_name ASC')
      if params[:q] == "" or params[:q] == nil
        respond_to do |format|
          format.js {render partial: 'room_table', locals: { rooms: @rooms } } 
        end
      elsif params[:q] 
        @rooms = @rooms.ransack(room_name_or_status_or_room_type_cont: params[:q]).result.order('order_name ASC')
        if @rooms
          respond_to do |format|
            format.js {render partial: 'room_table', locals: { rooms: @rooms } } 
          end
        else
          respond_to do |format|
            format.json {render json: {message: 'Không tìm thấy phòng nào :('}, status: :bad_request}
          end
        end
      end
    else
      @rooms = Room.where.not(id: 1)
      if params[:q] == "" or params[:q] == nil
        respond_to do |format|
          format.json {render json: {is_all: true}, status: :bad_request} 
        end
      elsif params[:q] 
        @rooms = @rooms.ransack(room_name_or_status_or_room_type_cont: params[:q]).result.order('order_name ASC')
        if @rooms
          respond_to do |format|
            format.js {render partial: 'room_table', locals: { rooms: @rooms } } 
          end
        else
          respond_to do |format|
            format.json {render json: {message: 'Không tìm thấy phòng nào :('}, status: :bad_request}
          end
        end
      end
    end
  end

  def room_number_student
    @room = Room.find(params[:id])
    respond_to do |format|
      format.json {render json: {room: @room}, status: :ok}
    end
  end

  def check_room_max_number_student_validation
     if @room = Room.find(params[:room_id])
      validation = @room.number_student > params[:max_number_student].to_i ? false : true
      respond_to do |format|
        format.json { render json: { validation: validation, number_student: @room.number_student}, status: :ok} 
      end
     else
      respond_to do |format|
        format.json {render json: {message: 'Không tìm thấy phòng!'}, status: :bad_request}
      end
     end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_type, :max_number_student)
  end

  def update_room_params
    params.permit(:room_type, :number_student, :max_number_student, :gender)
  end

end
