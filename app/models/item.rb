class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: [:disabled, :enabled]

  def self.enabled_items
    where(status: 1)
  end

  def self.disabled_items
    where(status: 0)
  end

  def find_invoice_id
    invoice_items.first.invoice.id
  end

  def item_best_day
    invoices.joins(:transactions)
            .where(transactions: {result: 0})
            .group(:id)
            .select("invoices.*, sum(invoice_items.quantity) as revenue")
            .order(revenue: :desc)
            .first.updated_at
  end
  
  

end
