class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def respond_with(resource, _opts = {})
    if resource[:id]
      render json: resource, status: 201
    else
      render json: resource.errors
    end
  end
end