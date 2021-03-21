class Student::ComplaintReportsController < StudentMainController
  before_action :set_complaint_report, only: %i[ show edit update destroy ]
  layout 'student_layout/student'

  # GET /complaint_reports or /complaint_reports.json
  def index
    @complaint_reports = ComplaintReport.all.where(student_id: current_user.id)
    @complaint_reports = current_user.complaint_reports

  end

  # GET /complaint_reports/1 or /complaint_reports/1.json
  def show
    @complaint_report = ComplaintReport.find(params[:id])
    respond_to do |format|
      format.json { render json: {complaint_report: @complaint_report}}
    end
  end

  # GET /complaint_reports/new
  def new
    @complaint_report = ComplaintReport.new
  end

  # GET /complaint_reports/1/edit
  def edit
  end

  # POST /complaint_reports or /complaint_reports.json
  def create
    @complaint_report = ComplaintReport.new(complaint_report_params)

    respond_to do |format|
      if @complaint_report.save
        format.html { redirect_to @complaint_report, notice: "Complaint report was successfully created." }
        format.json { render :show, status: :created, location: @complaint_report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @complaint_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaint_reports/1 or /complaint_reports/1.json
  def update
    respond_to do |format|
      if @complaint_report.update(complaint_report_params)
        format.html { redirect_to @complaint_report, notice: "Complaint report was successfully updated." }
        format.json { render :show, status: :ok, location: @complaint_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @complaint_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaint_reports/1 or /complaint_reports/1.json
  def destroy
    @complaint_report.destroy
    respond_to do |format|
      format.html { redirect_to complaint_reports_url, notice: "Complaint report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint_report
      @complaint_report = ComplaintReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def complaint_report_params
      params.require(:complaint_report).permit(:title)
    end
end
