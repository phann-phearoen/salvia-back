class EditorController < ApplicationController
    skip_before_action : authenticate_editor!, only: [:show, :index]
    def index
        @editors = Editor.all 
        render json: @editors
    end

    def create 
        editor = Editor.new(name: params[:name], email: params[:email], password: params[:password])
        editor.save
    end
end