# frozen_string_literal: true

module V1
  # Serializer for transactions
  class TransactionSerializer
    include JSONAPI::Serializer
    attributes :status, :merchant, :parent_id, :parent_type, :type, :uuid, :amount, :customer_email, :customer_phone,
               :notification_url, :created_at
  end
end
