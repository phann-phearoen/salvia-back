class class Api::V1::AdController < ApplicationController
    def index
        @first_ad = Ad.first 
        render json: @first_ad
    end

    def show

    end
end