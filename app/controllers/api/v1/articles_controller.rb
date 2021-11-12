class Api::V1::ArticlesController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        articles = Article.all
        render json: ArticleSerializer.new(articles)
    end
end