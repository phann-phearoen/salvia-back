class Api::V1::EditorController < ApplicationController
    skip_before_action :doorkeeper_authorize!, only: %i[create]

    def index
        @editors = Editor.all 
        render json: @editors
    end

    def create
      editor = Editor.new(name: editor_params[:name], email: editor_params[:email], password: editor_params[:password])

      client_app = Doorkeeper::Application.find_by(uid: params[:client_id])

      return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

      if editor.save
        # create access token for the editor, so the editor won't need to login again after registration
        access_token = Doorkeeper::AccessToken.create(
          resource_owner_id: editor.id,
          application_id: client_app.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
        
        # return json containing access token and refresh token
        # so that user won't need to call login API right after registration
        render(json: {
          editor: {
            id: editor.id,
            email: editor.email,
            access_token: access_token.token,
            token_type: 'bearer',
            expires_in: access_token.expires_in,
            refresh_token: access_token.refresh_token,
            created_at: access_token.created_at.to_time.to_i
          }
        })
      else
        render(json: { error: editor.errors.full_messages }, status: 422)
      end
    end

    private

    def editor_params
      params.permit(:name, :email, :password)
    end

    def generate_refresh_token
      loop do
        # generate a random token string and return it, 
        # unless there is already another token with the same string
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end
end