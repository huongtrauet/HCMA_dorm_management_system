Rails.application.routes.draw do
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
