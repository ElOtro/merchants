# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_309_011_753) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'admins', force: :cascade do |t|
    t.string 'name', comment: 'name'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
  end

  create_table 'merchants', force: :cascade do |t|
    t.boolean 'status', default: false, comment: 'activated or not'
    t.string 'name', comment: 'name'
    t.string 'description', comment: 'description'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_merchants_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_merchants_on_reset_password_token', unique: true
    t.index ['status'], name: 'index_merchants_on_status'
  end

  create_table 'transactions', force: :cascade do |t|
    t.bigint 'merchant_id', null: false, comment: 'Merchant'
    t.bigint 'parent_id', comment: 'Parent transaction ID'
    t.string 'parent_type', comment: 'Parent transaction type'
    t.string 'type', comment: 'Used for STI'
    t.uuid 'uuid', comment: 'UUID'
    t.bigint 'amount', default: 0, comment: 'Amount of transaction'
    t.integer 'status'
    t.text 'customer_email', default: '', null: false
    t.text 'customer_phone'
    t.text 'notification_url', comment: 'Used for callback'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['merchant_id'], name: 'index_transactions_on_merchant_id'
    t.index ['parent_id'], name: 'index_transactions_on_parent_id'
    t.index ['parent_type'], name: 'index_transactions_on_parent_type'
    t.index ['status'], name: 'index_transactions_on_status'
    t.index ['type'], name: 'index_transactions_on_type'
    t.index ['uuid'], name: 'index_transactions_on_uuid'
  end

  add_foreign_key 'transactions', 'merchants'
end
