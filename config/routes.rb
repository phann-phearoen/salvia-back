Rails.application.routes.draw do
  
  use_doorkeeper scope: 'api/v1/oauth' do
    controllers :tokens => 'api/v1/tokens'
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      #resources :article
      get '/article/get_total_pages', to: 'article#total_pages'
      get '/article/posts_index', to: 'article#admin_index'
      get '/article/search_article', to: 'article#search_article'
      get '/article/view', to: 'article#view_article'
      
      # resources :category
      get '/category', to: 'category#index'
      get '/category/search_category', to: 'category#search_category'
      get '/category/view', to: 'category#view_category'

      #resources :tags
      get '/tag', to: 'tag#index'
      get '/tag/search_tag', to: 'tag#search_tag'
      get '/tag/view', to: 'tag#view_tag'

      resources :editor
      root 'editor#index'
    end
  end
end
