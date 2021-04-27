class Student::FormRequestsController < StudentMainController
  before_action :set_form_request, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  layout 'student_layout/student'
  before_action :logged_in_student

  # GET /form_requests or /form_requests.json
  def index
    @form_requests = current_user.form_requests.order("created_at DESC").page(params[:page])
    @page = 1 if params[:page].blank?
    @page = params[:page].to_i if params[:page].present?
  end

  # GET /form_requests/1 or /form_requests/1.json
  def show
    @form_request = FormRequest.find(params[:id])
    respond_to do |format|
      format.json { render json: {form_request: @form_request}}
    end
  end

  # GET /form_requests/new
  def new
    @form_request = FormRequest.new
  end

  # GET /form_requests/1/edit
  def edit
  end

  # POST /form_requests or /form_requests.json
  def create
    last_index = 0
    last_index = current_user.form_requests.last.index if current_user.form_requests.length > 0
    @form_request = FormRequest.new(form_request_params.merge(student_id: current_user.id, index: last_index + 1))
      if @form_request.save
        count = FormRequest.all.where(student_id: current_user.id).count
        page = (FormRequest.where(status: 'PENDING').count.to_f / Settings.pagination).ceil
        if current_user.class.name == "Student"
          Notification.create(message: "#{current_user.name} đã gửi 1 yêu cầu mẫu đơn.", sender: current_user, receiver: Manager.first, noti_type: "create_form_request", report_id: @form_request.id, page: page )
        end
        respond_to do |format|
          format.json {render json: {message: "Tạo yêu cầu thành công!"}, status: :ok} 
        end
      else
        respond_to do |format|
          format.json { render json: {message: "Tạo yêu cầu thất bại :("}, status: :bad_request}
        end
      end
  end

  # PATCH/PUT /form_requests/1 or /form_requests/1.json
  def update
    respond_to do |format|
      if @form_request.update(form_request_params)
        format.html { redirect_to @form_request, notice: "Form request was successfully updated." }
        format.json { render :show, status: :ok, location: @form_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_requests/1 or /form_requests/1.json
  def destroy
    @form_request.destroy
    respond_to do |format|
      format.html { redirect_to form_requests_url, notice: "Form request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_request
      @form_request = FormRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def form_request_params
      params.require(:form_request).permit(:form_type, :description)
    end
end
