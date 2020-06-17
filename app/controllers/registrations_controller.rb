class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def respond_with(resource, _opts = {})
    if resource[:id]
      render json: resource
    else
      # render json: {errors: "The user already exists"}
    end
  end
end