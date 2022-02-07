class Api::V1::TagController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def index 
        reverser = Tag.order(id: :desc)

        page = params[:page] || last_page
        per = params[:per] || 10
        tags = reverser.page(page).per(per)

        total_count = Tag.count 
        response = {
            tags: tags,
            total_count: total_count
        }
        render json: response
    end

    def search_tag
        @name = params[:name]
        tags = Tag.where("display_name like ? ", "%#{@name}%")
        render json: tags, only: [:display_name, :detail, :slug, :id]
    end

    private
    def last_page
        Tag.page(1).per(10).total_pages
    end

end