# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    merchant { nil }
    uuid { '' }
    amount { '' }
    status { 1 }
    customer_email { 'MyText' }
    customer_phone { 'MyText' }
    notification_url { 'MyText' }
  end
end
