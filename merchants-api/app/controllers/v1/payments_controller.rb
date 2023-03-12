# frozen_string_literal: true

module V1
  class PaymentsController < ActionController::API
    include ::Auth::Merchant
    before_action :authenticate_request
    before_action :authenticate_merchant!

    def create
      # create new Transaction Object from factories
      transaction = Factories::Transactions::Base.for(current_merchant, payment_params).build
      ActiveRecord::Base.transaction do
        transaction.save!
        # transaction.validate_transaction!
      rescue StandardError => e
        transaction.errors.add(:base, e.message)
      end

      if transaction.valid?
        payload = V1::TransactionSerializer.new(transaction).to_hash.dig(:data, :attributes)

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
