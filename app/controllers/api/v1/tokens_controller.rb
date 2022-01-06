class Api::V1::TokensController < Doorkeeper::TokensController
	def create
		body = authorize_response.body
		oauth = OauthAccessToken.select(:resource_owner_id).where(token: body['access_token']).last
		if oauth
			editor_id = oauth.resource_owner_id

			if editor_id
				editor = Editor.get_editor_by_id editor_id
				body.merge!(editor: editor)
				headers.merge!(authorize_response.headers)
				render json: body,
					status: authorize_response.status				
			else
				logger.debug "[debug] no editor exists!"
				render status: 404 # wrong editor
			end
		else
			logger.debug "[debug] no token exists!"
			render status: 401 # wrong password
		end
	end
end