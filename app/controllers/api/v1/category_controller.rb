class Api::V1::CategoryController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index
        categories = Category.order(:creation_date).page(page || 1).per(10)

        response = []

        categories.each do |cat|
            obj = {}
            obj["title"] = cat.display_name
            obj["des"] = cat.detail
            obj["slug"] = cat.slug 
            obj["count"] = ''
            obj["id"] = cat.id 

            response.push(obj)
        end

        render json: response
    end
    
    def one_category        
        category = Category.where(id: params[:category_id])
        render json: category
    end

    private
    def page
        Category.page(10).total_pages
    end
end