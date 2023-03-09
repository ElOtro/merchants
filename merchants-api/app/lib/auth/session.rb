module Auth
  module Session
    private

    # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_user)
    def authenticate_request
      return unless request.headers['Authorization'].present?

      begin
        payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.secrets.secret_key_base, true,
                             { algorithm: 'HS256' }).first
        @user_id = payload['sub']
        puts "payload: #{payload}"
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end

    # If user has not signed in, return unauthorized response (called only when auth is needed)
    def authenticate_user!(_options = {})
      head :unauthorized unless signed_in?
    end

    # set Devise's current_user using decoded JWT instead of session
    def current_user
      @current_user ||= super || User.find(@user_id)
    end

    # check that authenticate_user has successfully returned @user_id (user is authenticated)
    def signed_in?
      @user_id.present?
    end
  end
end
