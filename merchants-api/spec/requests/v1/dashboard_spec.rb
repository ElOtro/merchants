require 'rails_helper'

RSpec.describe V1::DashboardController, type: :request do
  let(:user) { create_user }
  let(:sign_in_url) { '/users/sign_in' }

  describe 'GET /index' do
    context 'When get in dashboard' do
      before do
        sign_in_with_api(user)
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end
    end
  end
end
