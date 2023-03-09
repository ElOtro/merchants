class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  after_initialize :defaults

  private

  def defaults
    self.type ||= 'Merchant'
  end
end
