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

  def items_by_status_true
    items.where(status: true)
  end

  def items_by_status_false
    items.where(status: false)
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

  def invoices
    invoice_ids = items.joins(:invoices)
         .select('invoices.id as id, invoices.status as status')
         .distinct('invoices.id')
         .pluck('invoices.id')

    Invoice.where(id: invoice_ids)
  end
end
