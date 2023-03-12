# frozen_string_literal: true

class CaptureTransaction < Transaction
  belongs_to :parent, -> { where status: %i[approved captured] }, polymorphic: true
  has_many :refund_transactions, -> { where status: %i[pending approved captured], type: 'RefundTransaction' },
           as: :parent, dependent: :destroy
  validates :amount, numericality: { greater_than: 0 }
  validate  :amount, :total_amount

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false,
                skip_validation_on_save: true do
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
      transitions from: %i[approved], to: :refunded
    end
  end

  def validate_transaction!
    valid? ? approving! : declining!
  rescue StandardError => e
  end

  private

  def total_amount
    return if (parent.capture_transactions.sum(:amount) + amount) <= parent.amount

    errors.add(:amount,
               'amount is more than in parent transaction')
  end
end
