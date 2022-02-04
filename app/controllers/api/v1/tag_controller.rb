class Api::V1::TagController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        tags = Tag.all
        render json: tags, only: [:display_name, :detail, :slug, :id]
    end

    def search_tag
        @name = params[:name]
        tags = Tag.where("display_name like ? ", "%#{@name}%")
        render json: tags, only: [:display_name, :detail, :slug, :id]
    end

end