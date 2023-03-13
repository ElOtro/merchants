# frozen_string_literal: true

module Auth
  module Admin
    private

    # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_admin)
    def authenticate_request
      puts request.headers['Authorization']
      return unless request.headers['Authorization'].present?

      begin
        payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.secrets.secret_key_base, true,
                             { algorithm: 'HS256' }).first
        @admin_id = payload['sub']
        puts "payload: #{payload}"
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end

    # If admin has not signed in, return unauthorized response (called only when auth is needed)
    def authenticate_admin!(_options = {})
      head :unauthorized unless signed_in?
    end

    # set Devise's current_admin using decoded JWT instead of session
    def current_admin
      @current_admin ||= super || ::Admin.find(@admin_id)
    end

    # check that authenticate_admin has successfully returned @admin_id (admin is authenticated)
    def signed_in?
      @admin_id.present?
    end
  end
end
