Rails.application.routes.draw do
  devise_for :editors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :api, defaults: { format: :json } do
    resources :ad
    resources :user
    resources :editor
    
  end
end
