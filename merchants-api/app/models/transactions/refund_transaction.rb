class RefundTransaction < Transaction
  belongs_to :parent, -> { where status: [:approved, :refunded] }, polymorphic: true

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :error

    event :approving do
      after do
        parent&.refunding
      end
      transitions from: [:pending], to: :approved
    end

    event :declining do
      before do
      end
      transitions from: [:pending], to: :error
    end
  end
end
