# frozen_string_literal: true

module Factories
  module Transactions
    class Authorize
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def build
        attributes = { merchant_id: params[:merchant_id],
                       amount: params[:amount],
                       customer_email: params[:customer_email],
                       customer_phone: params[:customer_phone],
                       notification_url: params[:notification_url] }

        AuthorizeTransaction.new(attributes)
      end
    end
  end
end
