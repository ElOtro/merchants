# frozen_string_literal: true

module V1
  module Merchants
    class SessionsController < Devise::SessionsController
      respond_to :json

      def create
        resource = Merchant.find_for_database_authentication(email: params[:email])
        # return invalid_login_attempt unless resource
        if resource&.valid_password?(params[:password])
          token = generate_jwt(resource)
          render json: { token: }
        else
          render json: { errors: 'Not Authenticated' }, status: :unauthorized
        end
      end

      # DELETE /resource/sign_out
      def destroy
        respond_to_on_destroy
      end

      private

      def generate_jwt(resource)
        JWT.encode({ sub: resource.id, exp: 1.days.from_now.to_i, iss: 'merchant-api', aud: 'merchant-api' },
                   ENV['MERCHANT_JWT_SECRET_KEY'], 'HS256')
      end

      def respond_with(resource, _opts = {})
        render json: resource
      end

      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end
