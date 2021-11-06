class EditorController < ApplicationController
    skip_before_action :authenticate_user!, only: [:show, :index]
    def index
        @editors = Editor.all 
        render json: @editors
    end
end