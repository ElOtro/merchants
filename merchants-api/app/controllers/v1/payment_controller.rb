# frozen_string_literal: true

module V1
  class PaymentController < ActionController::API
    include ::Auth::Merchant
    before_action :authenticate_request
    before_action :authenticate_merchant!

    def create
      transaction = Transaction.new(transaction_params)

      if transaction.save
        render :show, status: :created
      else
        render json: @agreement.errors, status: :unprocessable_entity
      end
    end

    def transaction_params
      params.require(:transaction).permit(:type, :parent_id, :amount, :customer_email, :customer_phone,
                                          :notification_url)
    end
  end
end
