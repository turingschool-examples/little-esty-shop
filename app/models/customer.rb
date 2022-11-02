class Customer < ApplicationRecord
  has_many :invoices 
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  def name
    "#{first_name} #{last_name}"
  end
end