# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  has_many :transactions, as: :parent, dependent: :destroy

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :captured
    state :voided
    state :refunded
    state :error

    event :pending do
      after do
      end
      transitions from: [:approved], to: :pending
    end

    event :approving do
      after do
      end
      transitions from: [:pending], to: :approved
    end

    event :capturing do
      transitions from: [:approved], to: :captured
    end

    event :voiding do
      transitions from: %i[pending approved captured], to: :voided
    end

    event :declining do
      transitions from: [:pending], to: :error
    end

    event :refunding do
      transitions from: [:captured], to: :refunded
    end
  end
end
