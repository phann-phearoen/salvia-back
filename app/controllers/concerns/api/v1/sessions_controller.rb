class SessionsController < Devise::SessionsController
    def new
    end

    def create
        editor = Editor.find_by(email: params[:session][:email].downcase)
        if editor && editor.authenticate(params[:session][:password])
            session[:editor_id] = editor.id
            redirect_to editor_index_path
        else
            render json: 'failed'
        end
    end

    def destroy
        session[:editor_id] = nil
        redirect_to new_editor_session_path
    end
end