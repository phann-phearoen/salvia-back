class Api::V1::CategoryController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index
        categories = Category.all

        render json: categories, only: [:display_name, :detail, :slug, :id]
    end

    def search_category
        @name = params[:name]
        categories = Category.where("display_name like ? ", "%#{@name}%")
        render json: categories, only: [:display_name, :detail, :slug, :id]
    end
    
    private
    def page
        Category.page(10).total_pages
    end
end