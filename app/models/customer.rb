class Customer < ApplicationRecord
  has_many :invoices

  def successful_transactions(merchant_id)
    Transaction.joins(invoice: [:customer]
    ).where(result: 'success'
    ).where(customers: { id: id }
    ).joins(invoice: [invoice_items: [item: [:merchant]]]
    ).where(merchants: { id: merchant_id }
    ).count
  end
end
