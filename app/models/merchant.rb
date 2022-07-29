class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_items
    items
          .joins(:transactions)
          .select('items.*, count(transactions.result) as success_count')
         
         .where(transactions: { result: 'success' })
         .group(:id)
         .order('success_count desc')
         .limit(5)
  end
end


# def top_items
#   Item.joins(invoices: :transactions)
#       .where(invoices: {status: 1}, transactions: {result: 1})
#       .select("items.id, items.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
#       .group(:id)
#       .order("revenue desc")
#       .limit(5)
# end