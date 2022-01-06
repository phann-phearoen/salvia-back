class Api::V1::AdminController < ApplicationController
    skip_before_action :authenticate_editor!
    def index
        render json: 'Logged in successfully'
    end
end