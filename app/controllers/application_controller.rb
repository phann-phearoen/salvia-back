class ApplicationController < ActionController::API
    before_action :doorkeeper_authorize!

    private

    # helper method to access the current user from the token
    def current_editor
      @current_editor ||= Editor.find_by(id: doorkeeper_token[:resource_owner_id])
    end
end