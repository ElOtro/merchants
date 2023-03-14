# frozen_string_literal: true

class CaptureTransaction < Transaction
  belongs_to :parent, -> { where status: %i[approved captured refunded] }, polymorphic: true
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
      after do
        parent.refunding! if can_parent_transit?
      end
      transitions from: [:approved], to: :refunded
    end
  end

  private

  def can_parent_transit?
    parent.capture_transactions.sum(:amount) == parent.amount
  end

  def total_amount
    return if (parent.capture_transactions.sum(:amount) + amount) <= parent.amount

    errors.add(:amount,
               'amount is more than in a parent transaction')
  end
end
