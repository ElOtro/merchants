# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CaptureTransaction, type: :model do
  let(:merchant) { create :merchant }
  let(:authorize_transaction) { create :authorize_transaction, merchant: }
  let(:capture_transaction) { create :capture_transaction, merchant: }

  it 'is valid with valid attributes' do
    expect(CaptureTransaction.new(parent: authorize_transaction, merchant:, amount: 10_000)).to be_valid
  end

  it 'is not valid without an amount' do
    transaction = CaptureTransaction.new(parent: authorize_transaction, merchant:)
    expect(transaction).to_not be_valid
  end

  it 'is not valid without a parent' do
    transaction = CaptureTransaction.new(merchant:, amount: 10_000)
    expect(transaction).to be_valid
  end

  it 'status should be approved' do
    expect(capture_transaction.status.to_sym).to be :approved
  end

  it 'status should be error' do
    transaction = CaptureTransaction.create(parent: authorize_transaction, merchant:, amount: 11_000)
    transaction.transition_to_next_state
    expect(transaction.status.to_sym).to be :error
  end
end
