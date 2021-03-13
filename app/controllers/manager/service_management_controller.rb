class Manager::ServiceManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def index
  end

  def room_service_charge
    byebug
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

  def update_service_charge
    byebug
    @service_charge = ServiceCharge.find(service_charge_params[:charge_id])
    if @service_charge.update(service_charge_params.except(:charge_id, :index))
      respond_to do |format|
        format.js {render partial: 'charge_item', content_type: 'text/html', locals: { service_charge: @service_charge, index: service_charge_params[:index]} } 
      end
    else
      respond_to do |format|
        format.json {render message: "update fail" , status: :bad_request}
      end
    end
  end

  private

  def service_charge_params
    params.require(:service_charge).permit(:charge_id, :water_price, :electricity_price, :total_price, :status, :payer, :month, :year, :index)
  end

end