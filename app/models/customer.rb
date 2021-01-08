class Customer < ApplicationRecord
  has_many :invoices
  validates_presence_of :first_name, :last_name

  def self.top_five
    require 'pry'; binding.pry
    joins(:transactions).select("customers.*, count('transactions.result') as sales").group(:id).where('transactions.result = ?', 1).order(sales: :desc).limit(5)
  end
end
