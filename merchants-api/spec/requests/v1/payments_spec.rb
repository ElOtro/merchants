# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::PaymentsController, type: :request do
  let(:merchant) { create_active_merchant }

  let(:valid_attributes) do
    { type: 'authorize',
      parent_id: nil,
      amount: 10_000,
      customer_email: Faker::Internet.email,
      customer_phone: Faker::PhoneNumber.cell_phone_with_country_code,
      notification_url: 'http://example.com/notifications' }
  end

  let(:invalid_attributes) do
    { type: 'authorize',
      parent_id: nil,
      amount: 0,
      customer_email: nil,
      customer_phone: Faker::PhoneNumber.cell_phone_with_country_code,
      notification_url: 'http://example.com/notifications' }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        auth_merchant_with_api(merchant)
      end

      it 'creates a new AuthorizeTransaction' do
        expect do
          post '/v1/payments',
               params: { payment: valid_attributes },
               headers: { 'Authorization': "Bearer #{json['token']}" },
               as: :json
        end.to change(AuthorizeTransaction, :count).by(1)
      end

      it 'renders a JSON response with the new merchant' do
        post '/v1/payments',
             params: { payment: valid_attributes },
             headers: { 'Authorization': "Bearer #{json['token']}" },
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      before do
        auth_merchant_with_api(merchant)
      end

      it 'does not create a new AuthorizeTransaction' do
        expect do
          post '/v1/payments',
               params: { payment: invalid_attributes },
               headers: { 'Authorization': "Bearer #{json['token']}" },
               as: :json
        end.to change(AuthorizeTransaction, :count).by(0)
      end

      it 'renders a JSON response with errors for the new merchant' do
        post '/v1/payments',
             params: { payment: invalid_attributes },
             headers: { 'Authorization': "Bearer #{json['token']}" },
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
