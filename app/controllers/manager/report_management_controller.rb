class Manager::ReportManagementController < ApplicationController
  layout 'manager_layout/manager'
  skip_before_action :verify_authenticity_token
  # all room in room_management
  def complaint_report
    # @rooms = Room.where.not(id: 1)
  end
end