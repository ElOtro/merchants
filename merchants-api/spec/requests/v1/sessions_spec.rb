require 'rails_helper'

describe Users::SessionsController, type: :request do
  let(:user) { create_user }
  let(:sign_in_url) { '/users/sign_in' }
  let(:sign_out_url) { '/users/sign_out' }

  context 'When logging in' do
    before do
      sign_in_with_api(user)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When password is missing' do
    before do
      post sign_in_url, params: {
        user: {
          email: user.email,
          password: nil
        }
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
