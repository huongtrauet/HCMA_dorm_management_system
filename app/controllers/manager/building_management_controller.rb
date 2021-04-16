class Manager::BuildingManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager
  
  def index
    @buildings = Building.all
  end 

  def show
    @building = Building.find(params[:id])
    @rooms = @building.rooms
    total_floor = @building.total_floor

  end

  def create
    @building = Building.new(create_params)
    if @building.save
      respond_to do |format|
        format.json { render json: {building: @building, message: 'Create new building successfully'}, status: :ok}
      end
    else 
      respond_to do |format|
        format.json { render json: { message: 'Create new building failed'}, status: :bad_request}
      end
    end
  end

  def update
    if @building.update(update_params)
      respond_to do |format|
        format.json { render json: {building: @building, message: 'Update building successfully'}, status: :ok}
      end
    else 
      respond_to do |format|
        format.json { render json: {message: 'Update building failed'}, status: :bad_request}
      end
    end
  end

  def get_room_by_building_id
    @rooms = Building.find(params[:id]).rooms
    if @rooms
      respond_to do |format|
        format.json { render json: {rooms: @rooms, message: 'Get rooms  successfully'}, status: :ok}
      end
    else 
      respond_to do |format|
        format.json { render json: {message: 'Get rooms failed'}, status: :bad_request}
      end
    end
  end

  private

  def create_params
    params.require(:building).permit(:name)
  end

  def update_params
    params.require(:building).permit(:name)
  end
end
