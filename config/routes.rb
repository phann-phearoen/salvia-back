Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :editor
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      # resources :ad
      # resources :user
      resources :editor
      root 'editor#index'
    end
  end
end
