# frozen_string_literal: true

module Factories
  module Transactions
    class Base
      TYPES = {
        authorize: Factories::Transactions::Authorize,
        capture: Factories::Transactions::Capture,
        refund: Factories::Transactions::Refund
      }.freeze

      def self.for(merchant, params)
        raise 'Invalid type of transaction.' unless TYPES.key? params[:type]&.to_sym
        raise 'Invalid merchant.' unless merchant.status

        TYPES[params[:type].to_sym].new(params.except(:type).merge(merchant_id: merchant.id))
      end
    end
  end
end
