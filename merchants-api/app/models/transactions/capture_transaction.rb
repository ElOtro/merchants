# frozen_string_literal: true

class CaptureTransaction < Transaction
  belongs_to :parent, -> { where status: %i[approved captured] }, polymorphic: true, optional: true
  has_many :refund_transactions, -> { where status: %i[approved captured], type: 'RefundTransaction' },
           as: :parent, dependent: :destroy
  validates :amount, numericality: { greater_than: 0 }
  # validate  :amount, :total_amount

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :error
    state :refunded

    event :approving do
      after do
        parent.capturing! if can_parent_transit?
      end
      transitions from: [:pending], to: :approved
    end

    event :declining do
      transitions from: [:pending], to: :error
    end

    event :refunding do
      transitions from: [:approved], to: :refunded
    end
  end

  def transition_to_next_state
    if !parent.nil? && merchant == parent&.merchant &&  total_amount_is_sufficient?
      approving!
    else
      declining!
    end
  end

  private

  def can_parent_transit?
    parent.capture_transactions.sum(:amount) == parent.amount
  end

  def total_amount_is_sufficient?
    (parent.capture_transactions.sum(:amount) + amount) <= parent.amount
  end
end
