class Manager::BuildingManagementController < ManagerMainController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  def index
    
  end

end
