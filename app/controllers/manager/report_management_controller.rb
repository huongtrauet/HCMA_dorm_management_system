class Manager::ReportManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  before_action :logged_in_manager
  # all room in room_management

  # list tất cả các complaint
  def complaint_report
    @complaint_reports = ComplaintReport.where(status: "PENDING").order("created_at DESC").page(params[:page])
  end

  # def find_complaint_report_by_status
  #   @complaint_reports = ComplaintReport.where(status: params[:status]).page(params[:page])
  #   respond_to do |format|
  #     format.js {render partial: 'report_table', locals: { reports: @complaint_reports } } 
  #   end
  # end
  # thông tin chi tiết 1 complaint
  def show_complaint_report
    @complaint_report = ComplaintReport.find(params[:id])
    @student = @complaint_report.student
    respond_to do |format|
      format.json { render json: {complaint_report: @complaint_report, reporter: @student.student_profile, room: @student.room.room_name, building: @student.room.building.name}}
    end
  end
# danh sách complaint đã approved
  def approved_complaint_report
    @complaint_reports = ComplaintReport.where(status: "APPROVED").order("updated_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# danh sách complaint pending
  def pending_complaint_report
    @complaint_reports = ComplaintReport.where(status: "PENDING").order("created_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# danh sách complaint đã bị rejected
  def rejected_complaint_report
    @complaint_reports = ComplaintReport.where(status: "REJECTED").order("updated_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# thuwcj hiện từ chối 1 complaint
  def deny_complaint_report
    @complaint_report = ComplaintReport.find(deny_report_params[:id])
    student_id = @complaint_report.student_id
    receiver_student = Student.find(student_id)
    if @complaint_report.update(deny_report_params.merge(status: 'REJECTED'))
      if deny_report_params[:reject_reason] == ""
        @complaint_report.update_attribute(:reject_reason, "Xin lỗi, chúng tôi hiện chưa thể xử lý yêu cầu của bạn. Mọi thắc mắc xin gặp cán bộ trực tiếp tại phòng tiếp nhận sinh viên để được giải đáp. Xin cám ơn!")
      end
      last_index = receiver_student.complaint_reports.last.index
      index = @complaint_report.index
      # ceil lm tròn lên
      page = ((last_index - index + 1).to_f / Settings.report_pagination).ceil 
      @pending_reports = ComplaintReport.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Xin lỗi, báo cáo của bạn đã bị từ chối :(", sender: current_user, receiver: receiver_student, noti_type: "complaint_report", report_id: @complaint_report.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Từ chối thất bại :("}, status: :bad_request}
      end
    end
  end
# thực hiện approve
  def approve_complaint_report
    @complaint_report = ComplaintReport.find(approve_report_params[:id])
    student_id = @complaint_report.student_id
    receiver_student = Student.find(student_id)
    if @complaint_report.update_attribute(:status, "APPROVED")
      @pending_reports = ComplaintReport.where(status: "PENDING")
      last_index = receiver_student.complaint_reports.last.index
      index = @complaint_report.index
      page = ((last_index - index + 1).to_f / Settings.report_pagination).ceil
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Báo cáo của bạn đã được thông qua.", sender: current_user, receiver: receiver_student, noti_type: "complaint_report", report_id: @complaint_report.id, page: page)
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Thông qua thất bại :("}, status: :bad_request}
      end
    end
  end

  # FACILITY

  def facility_report
    @facility_reports = FacilityReport.where(status: "PENDING").order("created_at DESC").page(params[:page])
  end
# xem chi tieets
  def show_facility_report
    @facility_report = FacilityReport.find(params[:id])
    @student = @facility_report.student
    respond_to do |format|
      format.json { render json: {facility_report: @facility_report, reporter: @student.student_profile, room: @student.room.room_name, building: @student.room.building.name}}
    end
  end
# dsanh sách đã thông qua
  def approved_facility_report
    @facility_reports = FacilityReport.where(status: "APPROVED").order("updated_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# danh sách đang xử lý
  def pending_facility_report
    @facility_reports = FacilityReport.where(status: "PENDING").order("created_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# danh sách đã từ chối
  def rejected_facility_report
    @facility_reports = FacilityReport.where(status: "REJECTED").order("updated_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# thực hiện reject
  def reject_facility_report
    @facility_report = FacilityReport.find(deny_report_params[:id])
    student_id = @facility_report.student_id
    receiver_student = Student.find(student_id)
    if @facility_report.update(deny_report_params.merge(status: 'REJECTED'))
      if deny_report_params[:reject_reason] == ""
        @facility_report.update_attribute(:reject_reason, "Xin lỗi, chúng tôi hiện chưa thể xử lý yêu cầu của bạn. Mọi thắc mắc xin gặp cán bộ trực tiếp tại phòng tiếp nhận sinh viên để được giải đáp. Xin cám ơn!")
      end
      last_index = receiver_student.facility_reports.last.index
      index = @facility_report.index
      page = ((last_index - index + 1).to_f / Settings.report_pagination).ceil
      @pending_reports = FacilityReport.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Xin lỗi, báo cáo của bạn đã bị từ chối :(", sender: current_user, receiver: receiver_student, noti_type: "facility_report", report_id: @facility_report.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Từ chối thất bại :("}, status: :bad_request}
      end
    end
  end

# thực hiện approved
  def approve_facility_report
    @facility_report = FacilityReport.find(approve_report_params[:id])
    student_id = @facility_report.student_id
    receiver_student = Student.find(student_id)
    if @facility_report.update_attribute(:status, "APPROVED")
      last_index = receiver_student.facility_reports.last.index
      index = @facility_report.index
      page = ((last_index - index + 1).to_f / Settings.report_pagination).ceil
      @pending_reports = FacilityReport.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'report_table', locals: { reports: @pending_reports } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Báo cáo của bạn đã được thông qua!", sender: current_user, receiver: receiver_student, noti_type: "facility_report", report_id: @facility_report.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Thông qua thất bại :("}, status: :bad_request}
      end
    end
  end


  # REQUEST FORM
# danh sách
  def form_request
    @form_requests = FormRequest.where(status: "PENDING").order("created_at DESC").page(params[:page])
  end

# show chi tiết
  def show_form_request
    @form_request = FormRequest.find(params[:id])
    @student = @form_request.student
    respond_to do |format|
      format.json { render json: {form_request: @form_request, reporter: @student.student_profile, room: @student.room.room_name, building: @student.room.building.name}}
    end
  end
# danh sách approved
  def approved_form_request
    @form_requests = FormRequest.where(status: "APPROVED").order("updated_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# danh sách pending
  def pending_form_request
    @form_requests = FormRequest.where(status: "PENDING").order("created_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# danh sách rejjected
  def rejected_form_request
    @form_requests = FormRequest.where(status: "REJECTED").order("updated_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end
# thuẹc hiện reject
  def reject_form_request
    @form_request = FormRequest.find(deny_form_request_params[:id])
    student_id = @form_request.student_id
    receiver_student = Student.find(student_id)
    if @form_request.update(deny_form_request_params.merge(status: 'REJECTED'))
      if deny_form_request_params[:note] == ""
        @form_request.update_attribute(:note, "Xin lỗi, chúng tôi hiện chưa thể xử lý yêu cầu của bạn. Mọi thắc mắc xin gặp cán bộ trực tiếp tại phòng tiếp nhận sinh viên để được giải đáp. Xin cám ơn!")
      end
      last_index = receiver_student.form_requests.last.index
      index = @form_request.index
      page = ((last_index - index + 1).to_f / Settings.report_pagination).ceil
      @pending_requests = FormRequest.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'form_request_table', locals: { requests: @pending_requests } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Xin lỗi, yêu cầu của bạn đã bị từ chối :(", sender: current_user, receiver: receiver_student, noti_type: "form_request", report_id: @form_request.id, page: page)
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Từ chối thất bại :("}, status: :bad_request}
      end
    end
  end

# thực hiện approveapprove
  def approve_form_request
    @form_request = FormRequest.find(approve_form_request_params[:id])
    student_id = @form_request.student_id
    receiver_student = Student.find(student_id)
    if @form_request.update(approve_form_request_params.merge(status: 'APPROVED'))
      if(approve_form_request_params[:return_date] == "")
        @form_request.update_attribute(:return_date, 2.days.from_now)
      end
      last_index = receiver_student.form_requests.last.index
      index = @form_request.index
      page = ((last_index - index + 1).to_f / Settings.report_pagination).ceil
      @form_requests = FormRequest.where(status: "PENDING")
      respond_to do |format|
        format.js {render partial: 'form_request_table', locals: { requests: @form_requests } } 
      end
      if current_user.class.name == "Manager"
        Notification.create(message: "Yêu cầu của bạn đã được thông qua!", sender: current_user, receiver: receiver_student, noti_type: "form_request", report_id: @form_request.id, page: page )
      end
    else
      respond_to do |format|
        format.json { render json: {message: "Thông qua thất bại :("}, status: :bad_request}
      end
    end
  end



  private

  def deny_report_params
    params.require(:report).permit(:id, :reject_reason)
  end

  def deny_form_request_params
    params.require(:report).permit(:id, :note)
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