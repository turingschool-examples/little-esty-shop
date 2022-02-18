class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true 

end
