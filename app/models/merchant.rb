class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def top_five_customers
    Customer.joins(invoices: :items)
            .where('merchant_id = ?', self.id)
            .joins(invoices: :transactions)
            .where('result = ?', "success")
            .select("customers.*, count('transactions.result') as successful_transactions")
            .group('customers.id')
            .order(successful_transactions: :desc)
            .limit(5)
  end

  def top_five_items
    Item.joins(:invoice_items)
        .where('merchant_id = ?', self.id)
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
        .group('items.id')
        .order(total_revenue: :desc)
        .limit(5)
  end
end



