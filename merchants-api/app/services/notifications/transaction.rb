# frozen_string_literal: true

module Notifications
  class Transaction
    include HTTParty
    attr_reader :notification_url
    attr_reader :transaction

    def initialize(transaction)
      @notification_url = transaction.notification_url
      @transaction = transaction
    end

    def notify
      payload = { unique_id: @transaction.uuid, amount: @transaction.amount, status: @transaction.status }
      self.class.post('https://httpbin.org/post', {
                        body: payload,
                        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
                      }).parsed_response
    end
  end
end
