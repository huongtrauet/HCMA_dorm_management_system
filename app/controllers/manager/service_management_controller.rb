class Manager::ServiceManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager

  def index
    @service_charges = ServiceCharge.all.order("year DESC").order("month DESC").page(params[:page])
    @rooms = Room.all.select(:id, :room_name)
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
        format.json {render message: "update fail" , status: :bad_request}
      end
    end
  end

  # UPDATE SERVICE CHARGE IN SERVICE CHARGE MANAGEMENT

  def update_service_charge
    @service_charge = ServiceCharge.find(service_charge_params[:charge_id])
    if @service_charge.update(service_charge_params.except(:charge_id, :index))
      respond_to do |format|
        format.js {render partial: 'service_charge_item', content_type: 'text/html', locals: { charge: @service_charge, index: service_charge_params[:index]} } 
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

    if filter_params[:month_filter] != "" and filter_params[:month_filter] != "ALL"
      @service_charges = @service_charges.where(month: filter_params[:month_filter]).order("year DESC").order("month DESC")
    end

    if filter_params[:min_charge] != "0" and filter_params[:min_charge] != "ALL"
      @service_charges = @service_charges.ransack(total_price_gteq: filter_params[:min_charge].to_f).result.order("year DESC").order("month DESC")
    end

    if filter_params[:max_charge] != "0" and filter_params[:max_charge] != "ALL"
      @service_charges = @service_charges.ransack(total_price_lteq: filter_params[:max_charge].to_f).result.order("year DESC").order("month DESC")
    end
    
    respond_to do |format|
      format.js {render partial: 'service_charge_table', content_type: 'text/html', locals: { service_charges: @service_charges} } 
    end
  end


  private

  def service_charge_params
    params.require(:service_charge).permit(:charge_id, :water_price, :electricity_price, :total_price, :status, :payer, :month, :year, :index)
  end

  def filter_params
    params.require(:filter).permit(:room_id_filter, :charge_filter, :month_filter, :status_filter, :min_charge, :max_charge)
  end

end