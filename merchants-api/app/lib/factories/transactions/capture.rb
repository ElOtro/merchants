# frozen_string_literal: true

module Factories
  module Transactions
    class Capture
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def build
        parent = AuthorizeTransaction.find_by(uuid: params[:parent_id])
        raise 'Invalid parent.' unless parent

        attributes = { merchant_id: params[:merchant_id],
                       parent:,
                       amount: params[:amount] }

        CaptureTransaction.new(attributes)
      end
    end
  end
end
