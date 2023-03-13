# frozen_string_literal: true

class Transaction < ApplicationRecord
  include AASM
  belongs_to :merchant
  validates :uuid, presence: true,
                   format: { with: /\A[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}\z/i }

  enum status: { pending: 1, approved: 2, captured: 3, voided: 4, refunded: 5, error: 6 }

  after_initialize :defaults

  private

  def defaults
    self.uuid ||= SecureRandom.uuid
  end
end
