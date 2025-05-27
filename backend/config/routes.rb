Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check


  resources :links, only: [:create, :show, :index]
  get "/:id", to: "links#show"
end
