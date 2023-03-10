# frozen_string_literal: true

module V1
  module Admins
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      def create
        build_resource(sign_up_params)
        resource.save

        render_resource(resource)
      end

      private

      def respond_with(resource, _opts = {})
        register_success && return if resource.persisted?

        register_failed
      end

      def register_success
        render json: { message: 'Signed up sucessfully.' }
      end

      def register_failed
        render json: { message: 'Something went wrong.' }
      end

      def render_resource(resource)
        if resource.errors.empty?
          render json: resource
        else
          validation_error(resource)
        end
      end

      def validation_error(resource)
        render json: {
          errors: [
            {
              status: '400',
              title: 'Bad Request',
              detail: resource.errors,
              code: '100'
            }
          ]
        }, status: :bad_request
      end
    end
  end
end
