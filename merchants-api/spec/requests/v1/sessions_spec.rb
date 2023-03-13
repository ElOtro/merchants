# frozen_string_literal: true

require 'rails_helper'

describe V1::Admins::SessionsController, type: :request do
  let(:admin) { create_admin }
  let(:sign_in_url) { '/v1/auth' }
  let(:sign_out_url) { '/v1/auth' }

  context 'When logging in' do
    before do
      auth_admin_with_api(admin)
    end

    it 'returns a token' do
      expect(json['token']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When password is missing' do
    before do
      post sign_in_url, params: {
        email: admin.email,
        password: nil
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end

  context 'When logging out' do
    it 'returns 204' do
      delete sign_out_url

      expect(response).to have_http_status(204)
    end
  end
end
