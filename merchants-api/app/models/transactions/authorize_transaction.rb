# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  has_many :transactions, as: :parent, dependent: :destroy
  has_many :capture_transactions,  -> { where status: %i[pending approved captured], type: 'CaptureTransaction' },
           as: :parent, dependent: :destroy

  validates :notification_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :amount, numericality: { greater_than: 0 }
  validates :customer_email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  aasm :status, namespace: :status, column: :status, enum: true, whiny_persistence: false,
                skip_validation_on_save: true do
    state :pending, initial: true
    state :approved
    state :voided
    state :error

    event :pending do
      after do
      end
      transitions from: [:approved], to: :pending
    end

    event :approving do
      after do
      end
      transitions from: [:pending], to: :approved
    end

    event :voiding do
      transitions from: %i[pending approved], to: :voided
    end

    event :declining do
      transitions from: [:pending], to: :error
    end
  end

  def validate_transaction!
    valid? ? approving! : declining!
  rescue StandardError => e
  end
end
