class Api::V1::ArticlesController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        articles = Article.order(:creation_date).page(page|| 1).per(10)      
        render json: ArticleSerializer.new(articles)
    end

    private
    def page
        Article.page(10).total_pages
    end
end