# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# create users
def create_fake_users
  admin_email = 'admin@example.com'
  merchant_emails = ['test@example.com', 'merchant@example.com']

  Admin.create!(name: Faker::Name.name, email: admin_email, password: '12345678', password_confirmation: '12345678')

  merchant_emails.each do |merchant_email|
    Merchant.create!(status: true, name: Faker::Company.name, description: Faker::Company.industry,
                     email: merchant_email, password: '12345678', password_confirmation: '12345678')
  end
end

def create_fake_transactions
  Merchant.all.each do |merchant|
    authorize = AuthorizeTransaction.create!(merchant_id: merchant.id, amount: rand(2000..4000), customer_email: Faker::Internet.email,
                                             customer_phone: Faker::PhoneNumber.cell_phone_with_country_code,
                                             notification_url: 'http:/example.com/notifications')

    authorize.approving!

    capture = CaptureTransaction.create!(merchant_id: authorize.merchant_id, parent: authorize, amount: authorize.amount, customer_email: authorize.customer_email,
                                         customer_phone: authorize.customer_phone,
                                         notification_url: nil)
    capture.approving!
  end
end

# create_fake_users
create_fake_transactions
