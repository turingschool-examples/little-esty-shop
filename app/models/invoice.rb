class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  def self.filter_by_unshipped_order_by_age
    joins(:invoice_items).distinct.select("invoices.id, invoices.created_at").where.not(invoice_items: {status: 'shipped'}).order(:created_at)
  end
end
