class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_five
    binding.pry
  end

  def sucessful_transactions
  
  end
end