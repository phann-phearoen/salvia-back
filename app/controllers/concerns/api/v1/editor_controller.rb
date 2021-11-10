class Api::V1::EditorController < ApplicationController
    def index
        @editors = Editor.all 
        render json: @editors
    end

    def create 
        editor = Editor.new(name: params[:name], email: params[:email], password: params[:password])
        editor.save
    end
end