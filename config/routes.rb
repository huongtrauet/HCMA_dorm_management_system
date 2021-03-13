Rails.application.routes.draw do
  resources :posts
  resources :managers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    root "students#index"
    resources :managers
  end

  namespace :manager do
    get "/login", to: "manager_sessions#new"
    post "/login", to: "manager_sessions#create"
    get "/logout", to: "manager_sessions#destroy"
    get "/students-arrangement", to: "students_arrangement#main"
    get "/service-management", to: "service_management#index"

    get "/post-management", to: "post_management#index"
    get "/post-management/show", to: "post_management#show"
    post "/post-management/create", to: "post_management#create"
    post "/post-management/update", to: "post_management#update"
    post "/post-management/", to: "post_management#change_post_status"
    post "/post-management/restore", to: "post_management#restore"

    get "/student-management", to: "student_management#index"
    get "/student-management/:id/show", to: "student_management#show"
    post "/student-management/create-member", to: "student_management#create_room_member"
    post "/student-management/create", to: "student_management#create"
    get  "/student-management/:id/edit", to: "student_management#edit"
    get  "/student-management/:id", to: "student_management#edit"
    patch  "/student-management/:id/update", to: "student_management#update"
    delete  "/student-management/:id/delete", to: "student_management#destroy"
    
    get "/room-management/", to: "room_management#index"
    get "/room-management/rooms/:room_id/members", to: "room_management#show_room_members"
    get "/room-management/rooms/:room_id/facilities", to: "room_management#show_room_facilities"
    get "/room-management/rooms/:room_id/service-charges", to: "room_management#show_room_service_charges"
    post "/room-management/checkduplicate", to: "room_management#check_duplicate_room"
    get "/room-management/rooms/:id", to: "room_management#show"
    get "/homepage/", to: "homepage_management#index"
    get "/posts/:id", to: "homepage_management#show"
    post "/room-management/create", to: "room_management#create"
    post "/room-management/rooms/:room_id/service-charge/:year/:month", to: "service_management#show_service_charge"
    post "/room-management/rooms/:room_id/service-charge/:year/:month/update", to: "service_management#update_service_charge"


    resources :students
    resources :managers
    resources :rooms
  end

  namespace :student do
    get "/login", to: "student_sessions#new"
    post "/login", to: "student_sessions#create"
    get "/logout", to: "student_sessions#destroy"
    get "/requests/facility", to: "facility_reports#index"
    get "/requests", to: "facility_reports#index"
    get "/requests/form", to: "form_requests#index"
    get "/requests/complaint", to: "complaint_reports#index"
    resources :student_profiles
    resources :rooms
    resources :requests
    resources :notifications
    resources :facility_reports
    resources :complaint_reports
    resources :form_requests
    resources :facilities
    resources :service_charges
  end
end
