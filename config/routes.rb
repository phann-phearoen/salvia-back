Rails.application.routes.draw do
  
  use_doorkeeper scope: 'api/v1/oauth' do
    controllers :tokens => 'api/v1/tokens'
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      #resources :article
      get '/article/posts_index', to: 'article#admin_index'
      get '/article/search_article', to: 'article#search_article'
      get '/article/view', to: 'article#view_article'
      get '/article/get_by_id', to: 'article#get_article_by_id'
      get '/article/highlight', to: 'article#highlights'
      get '/article/feeds', to: 'article#feeds'
      delete '/article/delete', to: 'article#delete'
      
      # resources :category
      get '/category', to: 'category#index'
      get '/category/search_category', to: 'category#search_category'
      get '/category/view', to: 'category#view_category'
      get '/category/select', to: 'category#category_selector'

      #resources :tags
      get '/tag', to: 'tag#index'
      get '/tag/search_tag', to: 'tag#search_tag'
      get '/tag/view', to: 'tag#view_tag'
      get '/tag/select', to: 'tag#tag_selector'

      resources :editor
      root 'editor#index'
    end
  end
end
