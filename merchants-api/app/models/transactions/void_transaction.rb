# frozen_string_literal: true

class VoidTransaction < Transaction
  belongs_to :authorize_transaction, optional: true, foreign_key: 'transaction_id'
end
