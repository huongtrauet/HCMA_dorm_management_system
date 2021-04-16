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
        format.json {render json: {message: 'Created facility successfully'}, status: :ok } 
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Created facility fail'}, status: :bad_request } 
      end
    end
  end

  def update
    @facility = Facility.find(params[:id])
    if @facility.update(update_facility_params)
      respond_to do |format|
        format.json {render json: {message: 'Updated facility successfully'}, status: :ok } 
      end
    else
      respond_to do |format|
        format.json {render json: {message: 'Updated facility failed'}, status: :bad_request } 
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