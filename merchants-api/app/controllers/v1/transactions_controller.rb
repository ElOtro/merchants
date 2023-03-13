# frozen_string_literal: true

module V1
  class TransactionsController < V1::BaseController
    before_action :authenticate_admin!

    def index
      @transactions = Transaction.includes(:merchant)

      render json: V1::TransactionSerializer.new(@transactions)
    end
  end
end
