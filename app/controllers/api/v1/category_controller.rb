class Api::V1::CategoryController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index
        reverser = Category.order(id: :desc)

        page = params[:page] || 1
        per = params[:per] || 10
        categories = reverser.page(page).per(per)

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
end