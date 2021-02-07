class Student::FacilityReportsController < StudentMainController
  before_action :set_facility_report, only: %i[ show edit update destroy ]
  layout 'student_layout/student'


  # GET /facility_reports or /facility_reports.json
  def index
    @facility_reports = FacilityReport.all
  end

  # GET /facility_reports/1 or /facility_reports/1.json
  def show
  end

  # GET /facility_reports/new
  def new
    @facility_report = FacilityReport.new
  end

  # GET /facility_reports/1/edit
  def edit
  end

  # POST /facility_reports or /facility_reports.json
  def create
    @facility_report = FacilityReport.new(facility_report_params)

    respond_to do |format|
      if @facility_report.save
        format.html { redirect_to @facility_report, notice: "Facility report was successfully created." }
        format.json { render :show, status: :created, location: @facility_report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facility_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facility_reports/1 or /facility_reports/1.json
  def update
    respond_to do |format|
      if @facility_report.update(facility_report_params)
        format.html { redirect_to @facility_report, notice: "Facility report was successfully updated." }
        format.json { render :show, status: :ok, location: @facility_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facility_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_reports/1 or /facility_reports/1.json
  def destroy
    @facility_report.destroy
    respond_to do |format|
      format.html { redirect_to facility_reports_url, notice: "Facility report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_report
      @facility_report = FacilityReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facility_report_params
      params.require(:facility_report).permit(:title)
    end
end
