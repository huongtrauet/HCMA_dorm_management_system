class Manager::ManagersController < ManagerMainController
  layout 'manager_layout/manager'
  before_action :set_manager, only: %i[ show edit update destroy ]

  # GET /managers or /managers.jsonn
  def index
    @managers = Manager.all
  end

  # GET /managers/1 or /managers/1.json
  def show
  end

  # GET /managers/new
  def new
    @manager = Manager.new
  end

  # GET /managers/1/edit
  def edit
  end

  # POST /managers or /managers.json
  def create
    @manager = Manager.new(manager_params)

    respond_to do |format|
      if @manager.save
        format.html { redirect_to @manager, notice: "Manager was successfully created." }
        format.json { render :show, status: :created, location: @manager }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /managers/1 or /managers/1.json
  def update
    respond_to do |format|
      if @manager.update(manager_params)
        format.html { redirect_to @manager, notice: "Manager was successfully updated." }
        format.json { render :show, status: :ok, location: @manager }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /managers/1 or /managers/1.json
  def destroy
    @manager.destroy
    respond_to do |format|
      format.html { redirect_to managers_url, notice: "Manager was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_student_and_room
    if params[:q] 
      @rooms = Room.where.not(id: 1).ransack(room_name_or_status_cont: params[:q]).result
      @students = Student.all.ransack(name_or_student_id_number_cont: params[:q]).result
      if @rooms or @students
        respond_to do |format|
          format.json {render json: {students: @students, rooms: @rooms}}
        end
      else 
        respond_to do |format|
          format.json {render json: {message: 'No result found'}, status: :bad_request}
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager
      @manager = Manager.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manager_params
      params.require(:manager).permit(:email)
    end
end
