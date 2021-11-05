class EditorController < ApplicationController
    def index
        @editors = Editor.all 
        render json: @editors
    end
end