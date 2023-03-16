# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :merchant, null: false, foreign_key: true, comment: 'Merchant'
      t.bigint     :parent_id, index: true, comment: 'Parent transaction ID'
      t.string     :parent_type, index: true, comment: 'Parent transaction type'
      t.string     :type, index: true, comment: 'Used for STI'
      t.uuid       :uuid, index: true, comment: 'UUID'
      t.bigint     :amount, default: 0, comment: 'Amount of transaction'
      t.integer    :status, index: true
      t.text       :customer_email, null: false, default: ''
      t.text       :customer_phone
      t.text       :notification_url, comment: 'Used for callback'

      t.timestamps
    end
  end
end
