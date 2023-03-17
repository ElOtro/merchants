# frozen_string_literal: true

# create users
def create_fake_users
  admin_email = 'admin@example.com'
  merchant_emails = ['merchant@example.com', 'antonia@steuber.co', 'efrain@pfannerstill.com"']

  Admin.create!(name: Faker::Name.name, email: admin_email, password: '12345678', password_confirmation: '12345678')

  merchant_emails.each do |merchant_email|
    Merchant.create!(status: true, name: Faker::Company.name, description: Faker::Company.industry,
                     email: merchant_email, password: '12345678', password_confirmation: '12345678')
  end
end

def create_fake_authorize_transactions
  Merchant.all.each do |merchant|
    start_date  = DateTime.now - 1.month
    end_date    = DateTime.now
    random_date = Time.at((start_date.to_f - end_date.to_f) * rand + end_date.to_f)

    15.times do
      authorize = AuthorizeTransaction.create!(merchant_id: merchant.id,
                                               amount: rand(2000..4000),
                                               customer_email: Faker::Internet.email,
                                               customer_phone: Faker::PhoneNumber.cell_phone_with_country_code,
                                               notification_url: 'http:/example.com/notifications',
                                               created_at: random_date,
                                               updated_at: random_date)

      sample_result = [1, 2, 3].sample
      if sample_result > 2
        authorize.declining!
      else
        authorize.approving!
      end
    end
  end
end

def create_fake_void_transactions
  AuthorizeTransaction.where(status: :approved).each do |authorize_transaction|
    void = VoidTransaction.create!(merchant_id: authorize_transaction.merchant_id,
                                   parent: authorize_transaction,
                                   created_at: authorize_transaction.created_at,
                                   updated_at: authorize_transaction.updated_at)
    void.approving!
  end
end

def create_fake_capture_transactions
  AuthorizeTransaction.where(status: :approved).each do |authorize_transaction|
    capture = CaptureTransaction.create!(merchant_id: authorize_transaction.merchant_id,
                                         parent: authorize_transaction,
                                         amount: authorize_transaction.amount,
                                         customer_email: authorize_transaction.customer_email,
                                         customer_phone: authorize_transaction.customer_phone,
                                         notification_url: nil,
                                         created_at: authorize_transaction.created_at,
                                         updated_at: authorize_transaction.updated_at)
    capture.approving!
  end
end

def create_fake_refund_transactions
  CaptureTransaction.where(status: [:approved]).take(4).each do |capture_transaction|
    created_at = capture_transaction.created_at + [1, 2, 3].sample.days
    refund = RefundTransaction.create!(merchant_id: capture_transaction.merchant_id,
                                       parent: capture_transaction,
                                       amount: capture_transaction.amount,
                                       customer_email: capture_transaction.customer_email,
                                       customer_phone: capture_transaction.customer_phone,
                                       notification_url: nil,
                                       created_at:, updated_at: created_at)
    refund.approving!
  end
end

create_fake_users
create_fake_authorize_transactions
create_fake_void_transactions
create_fake_capture_transactions
create_fake_refund_transactions
