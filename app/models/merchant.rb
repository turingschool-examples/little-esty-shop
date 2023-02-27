class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
   
  def merchant_invoices
    invoices.distinct.order(:id)
  end

  def items_not_yet_shipped
    invoices.order(created_at: :asc)
    invoice_items.where.not(status: "shipped")
  end

  def merchant_top_5_customers
    self.customers.joins(:transactions).where(transactions: {result: 0}).group("customers.id").select("CONCAT(customers.first_name,' ', customers.last_name) AS full_name, COUNT(DISTINCT transactions.id) AS successful_order").order(successful_order: :desc, full_name: :asc).limit(5)
  end
end
