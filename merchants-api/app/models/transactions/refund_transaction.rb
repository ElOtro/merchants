# frozen_string_literal: true

class RefundTransaction < Transaction
  belongs_to :parent, -> { where status: %i[approved refunded] }, polymorphic: true
  validates :amount, numericality: { greater_than: 0 }
  # validate  :amount, :total_amount

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
      before do
      end
      transitions from: [:pending], to: :error
    end
  end

  private

  def can_parent_transit?
    parent.refund_transactions.sum(:amount) == parent.amount
  end

  def total_amount
    return if (parent.refund_transactions.sum(:amount) + amount) <= parent.amount

    errors.add(:amount,
               'amount is more than in parent transaction')
  end
end
