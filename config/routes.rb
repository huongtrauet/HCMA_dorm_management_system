Rails.application.routes.draw do
  resources :posts
  resources :managers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    root "students#index"
    resources :managers
  end
  mount ActionCable.server => '/cable'
  namespace :manager do
    get "/" => redirect("/manager/students-arrangement")

    get "/login", to: "manager_sessions#new"
    post "/login", to: "manager_sessions#create"
    get "/logout", to: "manager_sessions#destroy"
    get "/students-arrangement", to: "students_arrangement#main"

    get "/service-management", to: "service_management#index"
    post "/service-management/:id/:year/:month", to: "service_management#show_service_charge"
    post "/service-management/:id/:year/:month/update", to: "service_management#update_service_charge"
    # get "/service-management/find", to: "service_management#find_service_chare"
    get "/service-management/filter", to: "service_management#filter"
    post "/service-management/remind", to: "service_management#remind"
    post "/service-management/import", to: "service_management#import"


    get "/post-management", to: "post_management#index"
    get "/post-management/show", to: "post_management#show"
    post "/post-management/create", to: "post_management#create"
    put "/post-management/update", to: "post_management#update"
    post "/post-management/", to: "post_management#change_post_status"
    post "/post-management/restore", to: "post_management#restore"
    get "/post-management/find-post", to: "post_management#find_post"
    get "/post-management/:id", to: "post_management#show"


    get "/student-management", to: "student_management#index"
    put "/student-management/reset-ava", to: "student_management#reset_ava"
    post "/student-management/:id/update-avatar", to: "student_management#update_avatar"
    get "/student-management/search-students", to: "student_management#search_student"
    get "/student-management/:id/show", to: "student_management#show"
    post "/student-management/create-member", to: "student_management#create_room_member"
    post "/student-management/create", to: "student_management#create"
    get  "/student-management/:id/edit", to: "student_management#edit"
    get  "/student-management/pending-students", to: "student_management#find_pending_student"
    get  "/student-management/:id", to: "student_management#edit"
    patch  "/student-management/:id/update", to: "student_management#update"
    delete  "/student-management/:id/delete", to: "student_management#destroy"
    post "/student-management/checkduplicate", to: "student_management#check_duplicate_student"
    # get "/student-management/find-student", to: "student_management#find_student"
    
    get "/room-management/", to: "room_management#index"
    get "/room-management/rooms/:room_id/active_room", to: "room_management#active_room"
    get "/room-management/rooms/:room_id/members", to: "room_management#show_room_members"
    get "/room-management/rooms/:room_id/facilities", to: "room_management#show_room_facilities"
    get "/room-management/rooms/:room_id/service-charges", to: "room_management#show_room_service_charges"
    get "/room-management/rooms/:room_id/informations", to: "room_management#show_room_informations"
    put "/room_management/:id/update", to: "room_management#update"
    post "/room-management/checkduplicate", to: "room_management#check_duplicate_room"
    get "/room-management/rooms/:room_id", to: "room_management#show_room_informations"
    get "/homepage/", to: "homepage_management#index"
    get "/posts/:id", to: "homepage_management#show"
    post "/room-management/create", to: "room_management#create"
    post "/room-management/rooms/:room_id/service-charge/:year/:month", to: "service_management#show_service_charge"
    post "/room-management/rooms/:room_id/service-charge/:year/:month/update", to: "service_management#update_room_service_charge"
    get "/room-management/find-room", to: "room_management#find_room"
    get "/room-management/:id/number-student", to: "room_management#room_number_student"

    post "/facility-management/create", to: "facility_management#create"
    put "/facility-management/:id/update", to: "facility_management#update"
    get "/facility-management/:id", to: "facility_management#show"

    post "/students-arrangement/remove-student", to: "students_arrangement#remove_student_from_room"
    post "/students-arrangement/add-student", to: "students_arrangement#add_student_to_room"
    get "/students-arrangement/all-rooms-arrangement", to: "students_arrangement#search_rooms_arrangement"
    get "/students-arrangement/all-pending-students-arrangement", to: "students_arrangement#search_pending_students_arrangement"

    get "/managers/search", to: "managers#search_student_and_room"

    get "/report-management/", to: "report_management#pending_complaint_report"
    get "/report-management/complaint-reports", to: "report_management#pending_complaint_report"
    get "/report-management/complaint-reports/pending", to: "report_management#pending_complaint_report"
    get "/report-management/complaint-reports/approved", to: "report_management#approved_complaint_report"
    get "/report-management/complaint-reports/rejected", to: "report_management#rejected_complaint_report"
    get "/report-management/complaint-reports/find-by-status", to: "report_management#find_complaint_report_by_status"
    get "/report-management/complaint-reports/:id", to: "report_management#show_complaint_report" 
    put "/report-management/complaint-reports/:id/reject", to: "report_management#deny_complaint_report"
    put "/report-management/complaint-reports/:id/approve", to: "report_management#approve_complaint_report"

    get "/report-management/facility-reports", to: "report_management#pending_facility_report"
    get "/report-management/facility-reports/pending", to: "report_management#pending_facility_report"
    get "/report-management/facility-reports/approved", to: "report_management#approved_facility_report"
    get "/report-management/facility-reports/rejected", to: "report_management#rejected_facility_report"
    get "/report-management/facility-reports/find-by-status", to: "report_management#find_facility_report_by_status"
    get "/report-management/facility-reports/:id", to: "report_management#show_facility_report"
    put "/report-management/facility-reports/:id/reject", to: "report_management#reject_facility_report"
    put "/report-management/facility-reports/:id/approve", to: "report_management#approve_facility_report"

    get "/report-management/form-requests", to: "report_management#pending_form_request"
    get "/report-management/form-requests/pending", to: "report_management#pending_form_request"
    get "/report-management/form-requests/approved", to: "report_management#approved_form_request"
    get "/report-management/form-requests/rejected", to: "report_management#rejected_form_request"
    get "/report-management/form-requests/find-by-status", to: "report_management#find_form_request_by_status"
    get "/report-management/form-requests/:id", to: "report_management#show_form_request"
    put "/report-management/form-requests/:id/reject", to: "report_management#reject_form_request"
    put "/report-management/form-requests/:id/approve", to: "report_management#approve_form_request"

    get "/building-management/", to: "building_management#index"
    get "/building-management/:id", to: "building_management#show"

      
    post "/reset-password", to: "reset_password_manager#reset_manager_password"
    get "/reset-password/edit", to: "reset_password_manager#edit_manager_password"
    post "/reset-password/update", to: "reset_password_manager#update_manager_password"

    
    resources :students
    resources :managers
    resources :rooms
  end
  
  namespace :student do
    get "/" => redirect("/student/my-profile")
    
    get "/login", to: "student_sessions#new"
    post "/login", to: "student_sessions#create"
    get "/logout", to: "student_sessions#destroy"
    get "/requests", to: "complaint_reports#index"
    
    get "/requests/facility", to: "facility_reports#index"
    get "/requests/facility/:id", to: "facility_reports#show"
    post "/facility-reports/create", to: "facility_reports#create"
    
    get "/requests/form", to: "form_requests#index"
    get "/requests/form/:id", to: "form_requests#show"
    post "/requests/form/create", to: "form_requests#create"
    
    get "/requests/complaint", to: "complaint_reports#index"
    get "/requests/complaint/:id", to: "complaint_reports#show"
    post "/complaint-reports/create", to: "complaint_reports#create"
    
    get "/room/member/show/", to: "rooms#show_member"
    
    post "/student-profile/update-avatar/", to: "student_profiles#update_avatar"
    put "/student-profile/reset-ava", to:"student_profiles#reset_ava"
    put "/student-profile/update", to:"student_profiles#update"
    put "/student-profile/reset-password", to:"student_profiles#reset_password"
    
    get "/my-room/", to: "rooms#room_member"
    get "/my-room/members", to: "rooms#room_member"
    get "/my-room/services", to: "rooms#room_service_charge"

    post "/reset-password", to: "reset_password_student#reset_student_password"
    get "/reset-password/edit", to: "reset_password_student#edit_student_password"
    post "/reset-password/update", to: "reset_password_student#update_student_password"

    get "/homepage/", to: "homepage#index"
    get "/posts/:id", to: "homepage#show"
    get "/my-profile/", to: "student_profiles#edit"
    
    resources :student_profiles
    resources :rooms
    resources :requests
    resources :notifications
    # resources :facility_reports
    resources :complaint_reports
    resources :form_requests
    # resources :facilities
    resources :service_charges
  end
  
  get "/notifications/unread", to: "notifications#count_unread_noti"
  get "/notifications/total", to: "notifications#count_unread_noti"
  put "/notifications/:id/read", to: "notifications#read_noti"
  resources :payments
end
