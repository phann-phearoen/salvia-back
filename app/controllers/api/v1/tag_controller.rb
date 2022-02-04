class Api::V1::TagController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        tags = Tag.all
        render json: tags, only: [:display_name, :detail, :slug, :id]
    end

    def search_tag
        tags = Tag.where("display_name like ?", params[:name])
        render json: tags, only: [:display_name, :detail, :slug, :id]
    end

end