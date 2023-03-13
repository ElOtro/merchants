# frozen_string_literal: true

require 'rails_helper'

describe V1::Admins::RegistrationsController, type: :request do
  let(:admin) { build_admin }
  let(:existing_admin) { create_admin }
  let(:signup_url) { '/v1/admins' }

  context 'When creating a new admin' do
    before do
      post signup_url, params: {
        admin: {
          email: admin.email,
          password: admin.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the admin email' do
      expect(json['email']).to eq(admin.email)
    end
  end
end
