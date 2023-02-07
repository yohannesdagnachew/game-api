# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
     render json: {
        status: {
          message: "Signed in successfully", code: 200, data: resource
        }
      }
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        status: {
          message: "Signed out successfully", code: 200
        }
      }
    else
      render json: {
        status: {
          message: "Signed out failed", code: 401
        }
      }
    end
  end
end
