class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def successful_transactions_count
    invoice_ids = self.invoices.pluck(:id)
    Transaction.where(invoice_id: invoice_ids).where(result: 'success').count
  end
end
