class Manager::ReportManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager
  # all room in room_management


  # COMPLAINT
  def complaint_report
    @complaint_reports = ComplaintReport.where(status: "PENDING").page(params[:page])
  end

  def find_complaint_report_by_status
    @complaint_reports = ComplaintReport.where(status: params[:status]).page(params[:page])
    respond_to do |format|
      format.js {render partial: 'report_table', locals: { reports: @complaint_reports } } 
    end
  end

  def show_complaint_report
    @complaint_report = ComplaintReport.find(params[:id])
    respond_to do |format|
      format.json { render json: {complaint_report: @complaint_report}}
    end
  end

  def approved_complaint_report
    @complaint_reports = ComplaintReport.where(status: "APPROVED").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def pending_complaint_report
    @complaint_reports = ComplaintReport.where(status: "PENDING").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def rejected_complaint_report
    @complaint_reports = ComplaintReport.where(status: "REJECTED").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def deny_complaint_report
    @complaint_report = ComplaintReport.find(deny_report_params[:id])
    student_id = @complaint_report.student_id
    receiver_student = Student.find(student_id)
    if @complaint_report.update(deny_report_params.merge(status: 'REJECTED'))
      last_index = receiver_student.complaint_reports.last.index
      index = @complaint_report.index
      page = ((last_index - index + 1).to_f / Settings.pagination).ceil
      @pending_reports = ComplaintReport.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Sorry, Your report was rejected", sender: current_user, receiver: receiver_student, noti_type: "complaint_report", report_id: @complaint_report.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Rejected failed!!!"}, status: :bad_request}
      end
    end
  end

  def approve_complaint_report
    @complaint_report = ComplaintReport.find(approve_report_params[:id])
    student_id = @complaint_report.student_id
    receiver_student = Student.find(student_id)
    if @complaint_report.update_attribute(:status, "APPROVED")
      @pending_reports = ComplaintReport.where(status: "PENDING")
      last_index = receiver_student.complaint_reports.last.index
      index = @complaint_report.index
      page = ((last_index - index + 1).to_f / Settings.pagination).ceil
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Your report was approved", sender: current_user, receiver: receiver_student, noti_type: "complaint_report", report_id: @complaint_report.id, page: page)
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Approved failed!!!"}, status: :bad_request}
      end
    end
  end

  # FACILITY

  def facility_report
    @facility_reports = FacilityReport.where(status: "PENDING").page(params[:page])
  end

  def show_facility_report
    @facility_report = FacilityReport.find(params[:id])
    respond_to do |format|
      format.json { render json: {facility_report: @facility_report}}
    end
  end

  def approved_facility_report
    @facility_reports = FacilityReport.where(status: "APPROVED").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def pending_facility_report
    @facility_reports = FacilityReport.where(status: "PENDING").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def rejected_facility_report
    @facility_reports = FacilityReport.where(status: "REJECTED").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def reject_facility_report
    @facility_report = FacilityReport.find(deny_report_params[:id])
    student_id = @facility_report.student_id
    receiver_student = Student.find(student_id)
    if @facility_report.update(deny_report_params.merge(status: 'REJECTED'))
      last_index = receiver_student.facility_reports.last.index
      index = @facility_report.index
      page = ((last_index - index + 1).to_f / Settings.pagination).ceil
      @pending_reports = FacilityReport.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Sorry, your report was rejectd", sender: current_user, receiver: receiver_student, noti_type: "facility_report", report_id: @facility_report.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Rejected failed!!!"}, status: :bad_request}
      end
    end
  end

  def find_facility_report_by_status
    @facility_reports = FacilityReport.where(status: params[:status]).page(params[:page])
    respond_to do |format|
      format.js {render partial: 'report_table', locals: { reports: @facility_reports } } 
    end
  end

  def approve_facility_report
    @facility_report = FacilityReport.find(approve_report_params[:id])
    student_id = @facility_report.student_id
    receiver_student = Student.find(student_id)
    if @facility_report.update_attribute(:status, "APPROVED")
      last_index = receiver_student.facility_reports.last.index
      index = @facility_report.index
      page = ((last_index - index + 1).to_f / Settings.pagination).ceil
      @pending_reports = ComplaintReport.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Your report was approved", sender: current_user, receiver: receiver_student, noti_type: "facility_report", report_id: @facility_report.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Approved failed!!!"}, status: :bad_request}
      end
    end
  end


  # REQUEST FORM

  def form_request
    @form_requests = FormRequest.where(status: "PENDING").page(params[:page])
  end


  def show_form_request
    @form_request = FormRequest.find(params[:id])
    respond_to do |format|
      format.json { render json: {form_request: @form_request}}
    end
  end

  def approved_form_request
    @form_requests = FormRequest.where(status: "APPROVED").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def pending_form_request
    @form_requests = FormRequest.where(status: "PENDING").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def rejected_form_request
    @form_requests = FormRequest.where(status: "REJECTED").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  def reject_form_request
    @form_request = FormRequest.find(deny_report_params[:id])
    student_id = @form_request.student_id
    receiver_student = Student.find(student_id)
    if @form_request.update(deny_report_params.merge(status: 'REJECTED'))
      last_index = receiver_student.form_requests.last.index
      index = @form_request.index
      page = ((last_index - index + 1).to_f / Settings.pagination).ceil
      @pending_requests = FormRequest.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'form_request_table', locals: { requests: @pending_requests } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Sorry, your request was rejected", sender: current_user, receiver: receiver_student, noti_type: "form_request", report_id: @form_request.id, page: page)
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Rejected failed!!!"}, status: :bad_request}
      end
    end
  end

  def find_form_request_by_status
    @form_requests = FormRequest.where(status: params[:status]).page(params[:page])
    respond_to do |format|
      format.js {render partial: 'form_request_table', locals: { requests: @form_requests } } 
    end
  end

  def approve_form_request
    @form_request = FormRequest.find(approve_form_request_params[:id])
    student_id = @form_request.student_id
    receiver_student = Student.find(student_id)
    if @form_request.update(approve_form_request_params.merge(status: 'APPROVED'))
      last_index = receiver_student.form_requests.last.index
      index = @form_request.index
      page = ((last_index - index + 1).to_f / Settings.pagination).ceil
      @form_requests = FormRequest.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'form_request_table', locals: { requests: @form_requests } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Your request was approved", sender: current_user, receiver: receiver_student, noti_type: "form_request", report_id: @form_request.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Approved failed!!!"}, status: :bad_request}
      end
    end
  end



  private

  def deny_report_params
    params.require(:report).permit(:id, :reject_reason)
  end

  def approve_report_params
    params.require(:report).permit(:id)
  end

  def feedback_form_request_params
    params.require(:report).permit(:id, :note)

  end

  def approve_form_request_params
    params.require(:report).permit(:id, :note, :return_date)
  end

end