# frozen_string_literal: true

class ProcessNotificationJob < ApplicationJob
  queue_as :transaction

  def perform(transaction_id)
    transaction = AuthorizeTransaction.find_by(id: transaction_id)

    if transaction
      Notifications::Transaction.new(transaction).notify
    else
      logger.fatal 'ProcessNotificationJob error!'
    end
  end
end
