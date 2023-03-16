# frozen_string_literal: true

module V1
  # Serializer for transactions
  class TransactionPaymentSerializer
    include JSONAPI::Serializer
    attributes :status, :created_at

    attribute :amount, if: proc { |record| record.amount.positive? }, &:amount
    attribute :id, &:uuid
    attribute :parent_id, if: proc { |record| record.parent } do |transaction|
      transaction.parent&.uuid
    end
  end
end
