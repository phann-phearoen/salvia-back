class Api::V1::ArticlesController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        articles = Article.page(1).per(5)
        render json: ArticleSerializer.new(articles)
    end
end