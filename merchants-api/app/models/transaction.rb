class Transaction < ApplicationRecord
  include AASM
  belongs_to :merchant, foreign_key: 'user_id'

  enum status: { pending: 1, approved: 2, captured: 3, voided: 4, refunded: 5, error: 6 }

  after_initialize :defaults

  private

  def defaults
    self.uuid ||= SecureRandom.uuid
  end
end
