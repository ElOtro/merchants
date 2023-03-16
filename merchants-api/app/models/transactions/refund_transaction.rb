# frozen_string_literal: true

class RefundTransaction < Transaction
  belongs_to :parent, -> { where status: %i[approved refunded] }, polymorphic: true, optional: true
  validates :amount, numericality: { greater_than: 0 }

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :error

    event :approving do
      after do
        parent.refunding! if can_parent_transit?
      end
      transitions from: [:pending], to: :approved
    end

    event :declining do
      transitions from: [:pending], to: :error
    end
  end

  def transition_to_next_state
    if !parent.nil? && merchant == parent&.merchant && total_amount_is_sufficient?
      approving!
    else
      declining!
    end
  end

  private

  def can_parent_transit?
    parent.refund_transactions.sum(:amount) == parent.amount
  end

  def total_amount_is_sufficient?
    (parent.refund_transactions.sum(:amount) + amount) <= parent.amount
  end
end
