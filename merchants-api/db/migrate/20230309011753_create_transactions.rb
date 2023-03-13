# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :merchant, null: false, foreign_key: true
      t.bigint     :parent_id, index: true
      t.string     :parent_type, index: true
      t.string     :type, index: true
      t.uuid       :uuid, index: true
      t.bigint     :amount
      t.integer    :status, index: true
      t.text       :customer_email, null: false, default: ''
      t.text       :customer_phone
      t.text       :notification_url

      t.timestamps
    end
  end
end
