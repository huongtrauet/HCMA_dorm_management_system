class Student::ServiceChargesController < StudentMainController
  before_action :set_service_charge, only: %i[ show edit update destroy ]

  # GET /service_charges or /service_charges.json
  def index
    @service_charges = ServiceCharge.all
  end

  # GET /service_charges/1 or /service_charges/1.json
  def show
  end

  # GET /service_charges/new
  def new
    @service_charge = ServiceCharge.new
  end

  # GET /service_charges/1/edit
  def edit
  end

  # POST /service_charges or /service_charges.json
  def create
    @service_charge = ServiceCharge.new(service_charge_params)

    respond_to do |format|
      if @service_charge.save
        format.html { redirect_to @service_charge, notice: "Service charge was successfully created." }
        format.json { render :show, status: :created, location: @service_charge }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_charges/1 or /service_charges/1.json
  def update
    respond_to do |format|
      if @service_charge.update(service_charge_params)
        format.html { redirect_to @service_charge, notice: "Service charge was successfully updated." }
        format.json { render :show, status: :ok, location: @service_charge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_charges/1 or /service_charges/1.json
  def destroy
    @service_charge.destroy
    respond_to do |format|
      format.html { redirect_to service_charges_url, notice: "Service charge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_charge
      @service_charge = ServiceCharge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_charge_params
      params.require(:service_charge).permit(:water_price)
    end
end
