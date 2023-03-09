class Merchant < User
  # def self.sti_name
  #   'merchant'
  # end
  has_many :transactions, foreign_key: 'user_id'
end
