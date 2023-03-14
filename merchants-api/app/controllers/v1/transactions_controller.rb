# frozen_string_literal: true

module V1
  class TransactionsController < V1::BaseController
    before_action :authenticate_admin!

    def index
      @transactions = Transaction.includes(:merchant)
      @transactions = ::Queries::Transactions.new(@transactions).call(filter_params)

      render json: V1::TransactionSerializer.new(@transactions)
    end

    # Only allow a list of trusted parameters through.
    def filter_params
      params.permit(:format, :status, :type, :sort, :direction, :page, :limit)
    end
  end
end
