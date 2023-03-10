# frozen_string_literal: true

class CaptureTransaction < Transaction
  attribute :my_string, :string
  belongs_to :parent, -> { where status: %i[approved captured] }, polymorphic: true

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :error
    state :refunded

    event :approving do
      transitions from: [:pending], to: :approved
    end

    event :declining do
      transitions from: [:pending], to: :error
    end

    event :refunding do
      transitions from: %i[pending approved], to: :refunded
    end
  end
end
