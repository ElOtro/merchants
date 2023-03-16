# frozen_string_literal: true

module Factories
  module Transactions
    class Refund
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def build
        parent = CaptureTransaction.find_by(uuid: params[:parent_id])
        raise 'Invalid parent transaction.' unless parent

        attributes = { merchant_id: params[:merchant_id],
                       parent:,
                       amount: params[:amount] }

        RefundTransaction.new(attributes)
      end
    end
  end
end
