# frozen_string_literal: true

module V1
  # Serializer for transactions
  class TransactionSerializer
    include JSONAPI::Serializer
    attributes :status, :amount, :created_at

    attribute :id, &:uuid

    attribute :parent_id, if: proc { |record| record.respond_to? :parent } do |transaction|
      transaction.parent.uuid
    end
  end
end
