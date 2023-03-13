# frozen_string_literal: true

module V1
  # Serializer for users
  class MerchantSerializer
    include JSONAPI::Serializer
    attributes :status, :name, :description, :email
  end
end
