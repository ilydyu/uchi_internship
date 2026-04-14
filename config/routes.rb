Rails.application.routes.draw do
 mount Rswag::Ui::Engine => "/api-docs"
 mount Rswag::Api::Engine => "/api-docs"
 get "up" => "rails/health#show", as: :rails_health_check

  resources :schools, only: [] do
    resources :classes, only: [ :index ] do
        resources :students, only: [ :index ]
    end
  end

  resources :students, only: [ :destroy, :create ]
end
