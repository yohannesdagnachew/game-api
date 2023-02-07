# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {
          message: "Signed up successfully", code: 200, data: resource
        }
      }
    else
      render json: {
        status: {
          message: "Sign up failed", code: 400, data: resource.errors
        }
    }
    end
  end
end
