class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  enum status: [ :disabled, :enabled ]

  def unshipped
    items.joins(invoice_items: :invoice)
    .select('invoices.id as invoice_id, invoices.created_at as invoice_created, name')
    .where.not('invoice_items.status = ?', 2)
    .distinct
    .order('invoices.created_at DESC')
  end

  def customers
    Customer.joins(invoices: :items).where('items.merchant_id = ?', self.id).distinct
  end

  def top_five_customers
    customers.joins(invoices: :transactions).where('transactions.result = ?', 0)
            .select('customers.*, count(invoices) as successful')
            .group(:id).order(successful: :desc)
            .limit(5)
  end
end
