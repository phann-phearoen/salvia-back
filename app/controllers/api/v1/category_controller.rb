class Api::V1::CategoryController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index
        category = Category.where(id: params[:category_id])
        render json: category
    end
end