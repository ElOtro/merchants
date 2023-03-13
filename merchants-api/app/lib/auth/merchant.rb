# frozen_string_literal: true

module Auth
  module Merchant
    private

    # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_merchant)
    def authenticate_request
      return unless request.headers['Authorization'].present?

      begin
        payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             ENV['MERCHANT_JWT_SECRET_KEY'], true,
                             { algorithm: 'HS256' }).first
        @merchant_id = payload['sub']
        puts "payload: #{payload}"
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end

    # If merchant has not signed in, return unauthorized response (called only when auth is needed)
    def authenticate_merchant!(_options = {})
      head :unauthorized unless signed_in?
    end

    # set Devise's current_merchant using decoded JWT instead of session
    def current_merchant
      @current_merchant ||= super || ::Merchant.find(@merchant_id)
    end

    # check that authenticate_merchant has successfully returned @merchant_id (merchant is authenticated)
    def signed_in?
      @merchant_id.present?
    end
  end
end
