class Student::ComplaintReportsController < StudentMainController
  before_action :set_complaint_report, only: %i[ show edit update destroy ]
  layout 'student_layout/student'
  skip_before_action :verify_authenticity_token

  # GET /complaint_reports or /complaint_reports.json
  def index
    # @complaint_reports = ComplaintReport.all.where(student_id: current_user.id)
    @complaint_reports = current_user.complaint_reports.order("created_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?

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
    last_index = current_user.complaint_reports.last.index
    @complaint_report = ComplaintReport.new(complaint_report_params.merge(student_id: current_user.id, index: last_index + 1))
    if @complaint_report.save
      if current_user.class.name == "Student"
        page = (ComplaintReport.where(status: 'PENDING').count.to_f / Settings.pagination).ceil
        Notification.create(message: "#{current_user.name} created new complaint report", sender: current_user, receiver: Manager.first, noti_type: "create_complaint_report", report_id: @complaint_report.id, page: page )
      end
      respond_to do |format|
        format.json {render json: { message: "Created new complaint report successfully!!!" }, status: :ok } 
      end
    else
      respond_to do |format|
        format.json {render json: {message: "Create new complaint report failed!!!"}, status: :bad_request}
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
      params.require(:complaint_report).permit(:title, :description)
    end
end
