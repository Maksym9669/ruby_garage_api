# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    render json: { "error": "User is not authorized" }, status: 401
  end
end
