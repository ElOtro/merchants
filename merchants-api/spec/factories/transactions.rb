# frozen_string_literal: true

FactoryBot.define do
  factory :authorize_transaction, class: AuthorizeTransaction do
    association :merchant, factory: :merchant
    amount { 10_000 }
    customer_email { Faker::Internet.email }
    customer_phone { Faker::PhoneNumber.cell_phone_with_country_code }
    notification_url { 'http://example.com/notifications' }

    after(:create, &:approved!)
  end

  factory :void_transaction, class: AuthorizeTransaction do
    association :parent, factory: :authorize_transaction

    after(:create, &:approved!)
  end

  factory :capture_transaction, class: CaptureTransaction do
    association :parent, factory: :authorize_transaction
    amount { 10_000 }

    after(:create, &:approved!)
  end

  factory :refund_transaction, class: RefundTransaction do
    association :parent, factory: :capture_transaction
    amount { 10_000 }

    after(:create, &:approved!)
  end
end
