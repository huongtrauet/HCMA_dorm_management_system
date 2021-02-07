class Student::FormRequestsController < StudentMainController
  before_action :set_form_request, only: %i[ show edit update destroy ]
  layout 'student_layout/student'

  # GET /form_requests or /form_requests.json
  def index
    @form_requests = FormRequest.all
  end

  # GET /form_requests/1 or /form_requests/1.json
  def show
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
    @form_request = FormRequest.new(form_request_params)

    respond_to do |format|
      if @form_request.save
        format.html { redirect_to @form_request, notice: "Form request was successfully created." }
        format.json { render :show, status: :created, location: @form_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form_request.errors, status: :unprocessable_entity }
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
      params.require(:form_request).permit(:type)
    end
end
