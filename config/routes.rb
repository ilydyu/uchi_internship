Rails.application.routes.draw do
 get "up" => "rails/health#show", as: :rails_health_check


  resources :shcools, only: [] do
   resources :classes, only: [ :index ] do
    resources :students, only: [ :index ]
   end
  end

   resources :students, only: [ :destroy, :create ]
end
