# frozen_string_literal: true

class VoidTransaction < Transaction
  belongs_to :parent, -> { where status: [:approved] }, polymorphic: true, optional: true

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :error

    event :approving do
      after do
        parent&.voiding!
      end
      transitions from: [:pending], to: :approved
    end

    event :declining do
      transitions from: [:pending], to: :error
    end
  end

  def transition_to_next_state
    if !parent.nil? && merchant == parent&.merchant
      approving!
    else
      declining!
    end
  end
end
