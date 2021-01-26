Rails.application.routes.draw do
  get 'sessions/new'
  resources :student_profiles
  resources :notifications
  resources :facility_reports
  resources :complaint_reports
  resources :form_requests
  resources :requests
  resources :facilities
  resources :service_charges
  resources :rooms
  resources :managers
  resources :students
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    root "students#index"
    resources :managers
    resources :students do
 
    end
    get "/login", to: "student_sessions#new"
    post "/login", to: "student_sessions#create"
  end
end
