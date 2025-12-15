Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :properties, only: [] do
      collection do
        post :import
      end
    end
  end
end
