class Manager::ServiceManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager

  def index
    @service_charges = ServiceCharge.all.order("year DESC").order("month DESC").order("created_at DESC").page(params[:page])
    @rooms = Room.all.where("room_name != 'A1_0000'").select(:id, :room_name)
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def room_service_charge
    @room_service_charges = ServiceCharge.where(room_id: params[:id]).order("year DESC").order("month DESC")
    respond_to do |format|
      format.json {render json: {object: @room_service_charges}}
    end
  end

  def show_service_charge
    @service_charge = ServiceCharge.find(params[:charge_id])
    @room = @service_charge.room
    if @service_charge
      respond_to do |format|
        format.json {render json: {service_charge: @service_charge, room: @room}}
      end
    else
      respond_to do |format|
        format.json { render json: @service_charge.errors, status: :bad_request }
      end
    end
  end

  # UPDATE SERVICE CHARGE IN ROOM MANAGEMENT
  def update_room_service_charge
    @service_charge = ServiceCharge.find(service_charge_params[:charge_id])
    if @service_charge.update(service_charge_params.except(:charge_id, :index))
      respond_to do |format|
        format.js {render partial: 'manager/room_management/charge_item', content_type: 'text/html', locals: { service_charge: @service_charge, index: service_charge_params[:index]} } 
      end
    else
      respond_to do |format|
        format.json {render message: "Cập nhật thất bại :(" , status: :bad_request}
      end
    end
  end

  # UPDATE SERVICE CHARGE IN SERVICE CHARGE MANAGEMENT

  def update_service_charge
    @service_charge = ServiceCharge.find(service_charge_params[:charge_id])
    params = service_charge_params
    if @service_charge.status === 'UNPAID' && service_charge_params[:status] === 'PAID'
      params.merge!(paid_at: Time.now)
    end
    if @service_charge.update(params.except(:charge_id, :index))
      respond_to do |format|
        format.json {render json: { charge: @service_charge, message: "Cập nhật hoá đơn thành công!" }, status: :ok} 
      end
    else
      respond_to do |format|
        format.json {render message: "update fail" , status: :bad_request}
      end
    end
  end

  # FILTER

  def filter
    @service_charges = ServiceCharge.all.order("year DESC").order("month DESC")
    if filter_params[:status_filter] != "ALL" and filter_params[:status_filter] != ""
      @service_charges = @service_charges.where(status: filter_params[:status_filter]).order("year DESC").order("month DESC")
    end

    if filter_params[:room_id_filter] != "" and filter_params[:room_id_filter] != "ALL"
      @service_charges = @service_charges.where(room_id: filter_params[:room_id_filter]).order("year DESC").order("month DESC")
    end

    if filter_params[:month_filters] != "" and filter_params[:month_filters] != nil
      @service_charges = @service_charges.where(month: filter_params[:month_filters]).order("year DESC").order("month DESC")
    end

    if filter_params[:min_charge] != "0" and filter_params[:min_charge] != "ALL"
      @service_charges = @service_charges.ransack(total_price_gteq: filter_params[:min_charge].to_f).result.order("year DESC").order("month DESC")
    end

    if filter_params[:max_charge] != "0" and filter_params[:max_charge] != "ALL"
      @service_charges = @service_charges.ransack(total_price_lteq: filter_params[:max_charge].to_f).result.order("year DESC").order("month DESC")
    end

    if filter_params[:status_filter] == "UNPAID"
      is_check = true
    else
      is_check = false
    end
    respond_to do |format|
      format.js {render partial: 'service_charge_table', content_type: 'text/html', locals: { service_charges: @service_charges, is_check: is_check} } 
    end
  end

  def remind
    error = 0
    @service_charge= ServiceCharge.find(params[:charge_id])
    @room = @service_charge.room
    @students = @room.students
    @students.each do |student|
      Notification.create(message: "Nhắc nhờ nộp tiền dịch vụ tháng #{@service_charge.month}. Sinh viên nhanh chóng thanh toán hoá đơn phí dịch vụ tại phòng kế toán.", sender: current_user, receiver: student, noti_type: "service_charge_remind")
    end
  end

  def import
    begin
      if ServiceCharge.import_file params[:file]
        respond_to do |format|
          format.json {render json: { message: "Thêm dữ liệu thành công!" }, status: :ok} 
        end
      else
        respond_to do |format|
          format.json {render json: { message: "Thêm dữ liệu không thành công :(" }, status: :bad_request} 
        end
      end
    rescue Exception => e
      respond_to do |format|
        format.json {render json: { message: "Thêm dữ liệu không thành công :(" }, status: :bad_request} 
      end
    end
  end


  private

  def service_charge_params
    params.require(:service_charge).permit(:charge_id, :water_price, :electricity_price, :total_price, :status, :payer, :month, :year, :index)
  end

  def filter_params
    params.require(:filter).permit(:room_id_filter, :charge_filter, :status_filter, :min_charge, :max_charge, :month_filters => [])
  end

end