class Api::V1::CategoryController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index
        page = params[:page] || last_page
        per = params[:per] || 10
        categories = Category.order(:creation_date).page(page).per(per)

        total_count = Category.count
        response = {
            categories: categories,
            total_count: total_count,
        }
        render json: response
    end

    def search_category
        @name = params[:name]
        categories = Category.where("display_name like ? ", "%#{@name}%")
        render json: categories, only: [:display_name, :detail, :slug, :id]
    end
    
    private
    def last_page
        Category.page(1).per(10).total_pages
    end
end