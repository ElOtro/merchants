# frozen_string_literal: true

module V1
  class PaymentsController < ActionController::API
    include ::Auth::Merchant
    before_action :authenticate_request
    before_action :authenticate_merchant!

    def create
      # create new Transaction Object from factories
      transaction = Factories::Transactions::Base.for(current_merchant, payment_params).build
      if transaction.valid? && transaction.save
        payload = V1::TransactionPaymentSerializer.new(transaction).to_hash.dig(:data, :attributes)

        render json: { data: payload }, status: :created
      else
        render json: transaction.errors, status: :unprocessable_entity
      end
    # errors may come from factories
    rescue StandardError => e
      render json: { error: e }, status: :unprocessable_entity
    end

    def payment_params
      params.require(:payment).permit(:type, :parent_id, :amount, :customer_email, :customer_phone,
                                      :notification_url)
    end
  end
end
