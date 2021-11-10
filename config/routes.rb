Rails.application.routes.draw do
  
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      # resources :ad
      # resources :user
      resources :editor
      root 'editor#index'
    end
  end
end
