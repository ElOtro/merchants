# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    description { Faker::Company.industry }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :active do
      status { true }
    end

    trait :inactive do
      status { false }
    end
  end
end
