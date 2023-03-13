# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::DashboardController, type: :request do
  let(:admin) { create_admin }

  describe 'GET /index' do
    context 'When get in dashboard' do
      before do
        auth_admin_with_api(admin)
      end

      it 'returns 200' do
        get '/v1/dashboard',
            headers: { 'Authorization': "Bearer #{json['token']}" },
            as: :json
        expect(response.status).to eq(200)
      end
    end
  end
end
