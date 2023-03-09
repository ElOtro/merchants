class CaptureTransaction < Transaction
  belongs_to :parent, -> { where status: [:approved, :captured] }, polymorphic: true

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
      transitions from: [:pending, :approved], to: :refunded
    end
  end
end
