# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module UserHelpers
  def create_admin
    FactoryBot.create(:admin,
                      name: Faker::Name.name,
                      email: Faker::Internet.email,
                      password: Faker::Internet.password)
  end

  def build_admin
    FactoryBot.build(:admin,
                     name: Faker::Name.name,
                     email: Faker::Internet.email,
                     password: Faker::Internet.password)
  end

  def create_active_merchant
    FactoryBot.create(:merchant,
                      status: true,
                      name: Faker::Company.name,
                      description: Faker::Company.industry,
                      email: Faker::Internet.email,
                      password: Faker::Internet.password)
  end

  def build_active_merchant
    FactoryBot.build(:merchant,
                     status: true,
                     name: Faker::Company.name,
                     description: Faker::Company.industry,
                     email: Faker::Internet.email,
                     password: Faker::Internet.password)
  end

  def create_inactive_merchant
    FactoryBot.create(:merchant,
                      status: false,
                      name: Faker::Company.name,
                      description: Faker::Company.industry,
                      email: Faker::Internet.email,
                      password: Faker::Internet.password)
  end

  def build_inactive_merchant
    FactoryBot.build(:merchant,
                     status: false,
                     name: Faker::Company.name,
                     description: Faker::Company.industry,
                     email: Faker::Internet.email,
                     password: Faker::Internet.password)
  end
end
