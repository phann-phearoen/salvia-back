# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_from_credentials do |_routes|
    Editor.authenticate(params[:email], params[:password])
  end

  grant_flows %w[password]

  allow_blank_redirect_uri true

  skip_authorization do
    true
  end

  use_refresh_token
  
end
