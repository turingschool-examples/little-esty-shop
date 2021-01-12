class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :items

  def enabled_items
    Item.all_enabled_items.where(merchant_id: self.id)
  end

  def disabled_items
    Item.all_disabled_items.where(merchant_id: self.id)
  end

  def best_customers
    Invoice.where(merchant_id: self.id)
           .joins(:transactions, :customer)
           .select('customers.*, count(transactions) as most_success')
           .where('transactions.result = ?', 0)
           .group('customers.id')
           .order('most_success desc')
           .limit(5)
  end
end

# DELETE IF NOT NEEDED:
# Transaction.joins(invoice: :customer).select('customers.*, count(transactions) as total_success').where('transactions.result = ?', 1).group('customers.id').order('total_success DESC').limit(5)