class Api::V1::TagController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        tags = Tag.last(50).reverse
        render json: tags
    end
end