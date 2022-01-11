Rails.application.routes.draw do
  
  use_doorkeeper scope: 'api/v1/oauth' do
    controllers :tokens => 'api/v1/tokens'
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      # resources :ad
      # resources :user
      # resources :articles
      get '/articles/posts_index', to: 'articles#admin_index'
      
      resources :category
      resources :editor
      root 'editor#index'
    end
  end
end
