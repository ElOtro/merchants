# frozen_string_literal: true

module ApiHelpers
  def auth_admin_with_api(admin)
    post '/v1/auth', params: {
      email: admin.email,
      password: admin.password
    }
  end

  def auth_merchant_with_api(merchant)
    post '/v1/merchants/auth', params: {
      email: merchant.email,
      password: merchant.password
    }
  end
end
