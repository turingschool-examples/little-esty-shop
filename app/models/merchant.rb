class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_presence_of :name

  def top_five_customers
    list = Customer.distinct.joins(invoices: [:transactions, :invoice_items, :items])
                    .where('items.merchant_id = ? AND transactions.result = ?', "#{self.id}", "success")
                    
    binding.pry
  end
end