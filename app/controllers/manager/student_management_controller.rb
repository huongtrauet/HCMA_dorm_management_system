class Manager::StudentManagementController < ApplicationController
  layout 'manager_layout/manager'
  def index
    
  end

  def edit
    @student_profile = StudentProfile.new
  end
end
