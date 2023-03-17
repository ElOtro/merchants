class ProcessTransitionJob < ApplicationJob
  queue_as :transaction

  def perform(transaction)
    return unless [true, false].sample

    transaction.declining!
  end
end
