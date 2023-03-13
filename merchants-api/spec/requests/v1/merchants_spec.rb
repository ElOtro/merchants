# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::MerchantsController, type: :request do
  let(:admin) { create_admin }

  let(:valid_attributes) do
    { name: Faker::Company.name,
      description: Faker::Company.industry,
      email: Faker::Internet.email,
      password: '12345678' }
  end

  let(:invalid_attributes) do
    { name: Faker::Company.name,
      description: Faker::Company.industry,
      email: '',
      password: Faker::Internet.password }
  end

  describe 'GET /index' do
    context 'When get merchants' do
      before do
        auth_admin_with_api(admin)
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET /show' do
    context 'When get merchant' do
      before do
        auth_admin_with_api(admin)
      end

      it 'renders a successful response' do
        merchant = Merchant.create! valid_attributes
        get v1_merchant_url(merchant), headers: { 'Authorization': "Bearer #{json['token']}" }, as: :json
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        auth_admin_with_api(admin)
      end

      it 'creates a new Merchant' do
        expect do
          post '/v1/merchants',
               params: { merchant: valid_attributes },
               headers: { 'Authorization': "Bearer #{json['token']}" },
               as: :json
        end.to change(Merchant, :count).by(1)
      end

      it 'renders a JSON response with the new merchant' do
        post '/v1/merchants',
             params: { merchant: valid_attributes },
             headers: { 'Authorization': "Bearer #{json['token']}" },
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      before do
        auth_admin_with_api(admin)
      end

      it 'does not create a new Merchant' do
        expect do
          post '/v1/merchants',
               params: { merchant: invalid_attributes },
               headers: { 'Authorization': "Bearer #{json['token']}" },
               as: :json
        end.to change(Merchant, :count).by(0)
      end

      it 'renders a JSON response with errors for the new merchant' do
        post '/v1/merchants',
             params: { merchant: invalid_attributes },
             headers: { 'Authorization': "Bearer #{json['token']}" },
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        auth_admin_with_api(admin)
      end

      let(:new_attributes) do
        { name: Faker::Company.name }
      end

      it 'updates the requested merchant' do
        merchant = Merchant.create! valid_attributes
        patch v1_merchant_url(merchant),
              params: { merchant: new_attributes },
              headers: { 'Authorization': "Bearer #{json['token']}" },
              as: :json
        merchant.reload
        expect(merchant.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the merchant' do
        merchant = Merchant.create! valid_attributes
        patch v1_merchant_url(merchant),
              params: { merchant: new_attributes },
              headers: { 'Authorization': "Bearer #{json['token']}" },
              as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      before do
        auth_admin_with_api(admin)
      end

      it 'renders a JSON response with errors for the merchant' do
        merchant = Merchant.create! valid_attributes
        patch v1_merchant_url(merchant),
              params: { merchant: invalid_attributes },
              headers: { 'Authorization': "Bearer #{json['token']}" },
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      auth_admin_with_api(admin)
    end

    it 'destroys the requested merchant' do
      merchant = Merchant.create! valid_attributes
      expect do
        delete v1_merchant_url(merchant),
               headers: { 'Authorization': "Bearer #{json['token']}" },
               as: :json
      end.to change(Merchant, :count).by(-1)
    end
  end
end
