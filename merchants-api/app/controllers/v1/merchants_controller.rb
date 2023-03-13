# frozen_string_literal: true

module V1
  class MerchantsController < V1::BaseController
    before_action :authenticate_admin!
    before_action :set_merchant, only: %i[show update destroy]

    # GET /merchants
    def index
      @merchants = Merchant.all

      render json: V1::MerchantSerializer.new(@merchants)
    end

    # GET /merchants/1
    def show
      render json: V1::MerchantSerializer.new(@merchant)
    end

    # POST /merchants
    def create
      @merchant = Merchant.new(merchant_params)

      if @merchant.save
        render json: @merchant, status: :created
      else
        render json: @merchant.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /merchants/1
    def update
      if @merchant.update(merchant_params)
        render json: @merchant
      else
        render json: @merchant.errors, status: :unprocessable_entity
      end
    end

    # DELETE /merchants/1
    def destroy
      @merchant.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merchant_params
      params.require(:merchant).permit(:status, :name, :description, :email, :password, :password_confirmation)
    end
  end
end
