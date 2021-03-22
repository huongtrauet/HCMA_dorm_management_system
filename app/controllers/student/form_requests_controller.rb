class Student::FormRequestsController < StudentMainController
  before_action :set_form_request, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  layout 'student_layout/student'

  # GET /form_requests or /form_requests.json
  def index
    @form_requests = current_user.form_requests
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
    byebug
    @form_request = FormRequest.new(form_request_params.merge(student_id: current_user.id))
      if @form_request.save
        count = FormRequest.all.where(student_id: current_user.id).count
        respond_to do |format|
          format.js {render partial: 'form_request_line', locals: { request: @form_request, index: count } } 
        end
      else
        format.json { render json: {message: "Created failed!!!"}, status: :bad_request}
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
