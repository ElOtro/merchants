# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  has_many :transactions, as: :parent, dependent: :destroy
  has_many :capture_transactions,  -> { where status: %i[approved captured refunded], type: 'CaptureTransaction' },
           as: :parent, dependent: :destroy

  validates :notification_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :amount, numericality: { greater_than: 0 }
  validates :customer_email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false do
    state :pending, initial: true
    state :approved
    state :captured
    state :voided
    state :refunded
    state :error

    event :pending do
      after do
        # ProcessTransitionJob.perform_later(self)
      end
      transitions from: [:approved], to: :pending
    end

    event :approving do
      transitions from: [:pending], to: :approved
    end

    event :capturing do
      transitions from: [:approved], to: :captured
    end

    event :voiding do
      transitions from: [:approved], to: :voided
    end

    event :refunding do
      transitions from: %i[pending approved captured], to: :refunded
    end

    event :declining do
      transitions from: [:pending], to: :error
    end
  end

  def transition_to_next_state
    approving!
  end

  def parent
    nil
  end
end
