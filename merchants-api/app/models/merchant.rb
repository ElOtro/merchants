# frozen_string_literal: true

class Merchant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validate :check_transactions, on: :destroy

  private

  def check_transactions
    return true unless transactions.any?

    errors.add :base, 'Impossible delete, there are transactions!'
    throw(:abort)
  end
end
