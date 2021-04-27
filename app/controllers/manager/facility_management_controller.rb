class Manager::FacilityManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager
  
  # Create room facility
  def show
    @facility = Facility.find(params[:id])
    @room = @facility.room
    respond_to do |format|
      format.json { render json: {facility: @facility, room: @room}, status: :ok}
    end
  end

  def create
    @facility = Facility.new(create_facility_params)
    if @facility.save
      respond_to do |format|
        format.json {render json: {message: 'Tạo mới thiết bị thành công!'}, status: :ok } 
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Tạo mới thiết bị thất bại :('}, status: :bad_request } 
      end
    end
  end

  def update
    @facility = Facility.find(params[:id])
    params = update_facility_params
    params = update_facility_params.except(:status) if update_facility_params[:status] == ""
    
    if @facility.update(params)
      respond_to do |format|
        format.json {render json: {message: 'Cập nhật thiết bị thành công!'}, status: :ok } 
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Cập nhật thiết bị thất bại :('}, status: :bad_request } 
      end
    end
  end

  private

  def create_facility_params
    params.permit(:name, :detail, :room_id, {images: []})
  end

  def update_facility_params
    params.require(:facility).permit(:name, :detail, :quantity, :status, :detail)
  end
end