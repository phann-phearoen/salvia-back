class Api::V1::ArticlesController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        articles = Article.order(:creation_date).page(page|| 1).per(10) 
        
        response = []
        articles.each do |article|
            obj = {}
            if article.category_id?
                categories = []
                article.category_id.each do |cat|
                    category = Category.get_category_by_id(cat)              
                    categories.push(category)
                end
                obj["categories"] = categories
            end
            
            if article.editor_id?
                editor = Editor.get_editor_by_id(article.editor_id)
                obj["editor"] = editor
            end
            obj["contents"] = article

            response.push(obj)
        end

        render json: response
    end

    private
    def page
        Article.page(10).total_pages
    end
    def self.get_article_by_id article_id
        self.where(id: article_id).last
    end
end