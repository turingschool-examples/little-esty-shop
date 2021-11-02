class Merchant < ApplicationRecord
  has_many :items

  def top_customers
    item_ids = self.items.pluck(:id)
    invoice_ids = InvoiceItem.where(item_id: item_ids).distinct.pluck(:invoice_id)
    transaction_ids = Transaction.where(invoice_id: invoice_ids).pluck(:id)

    customer_ids = Invoice.where(id: invoice_ids).pluck(:customer_id)
    customers = Customer.where(id: customer_ids)

    binding.pry
  end
end
# find all customers related to merchant
