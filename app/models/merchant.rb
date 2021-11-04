class Merchant < ApplicationRecord
  has_many :items

  def favorite_customers
    id_tx_hash = Customer.joins(invoices: [:transactions]
      ).where(transactions: { result: 'success' }
      ).joins(invoices: [invoice_items: [item: [:merchant]]]
      ).where(merchants: { id: id }
      ).group(:id
      ).order(Arel.sql('COUNT(transactions.id) DESC')
      ).limit(5)
  end
end
