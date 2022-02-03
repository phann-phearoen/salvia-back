class Api::V1::CategoryController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index
        categories = Category.all

        render json: categories
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