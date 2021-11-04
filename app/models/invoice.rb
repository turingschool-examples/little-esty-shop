class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { "cancelled" => 0,
                 "completed" => 1,
                 "in progress" => 2
               }
  def self.successful_invoices
    joins(:transactions).where(transactions: {result: "success"}).distinct
  end

  def invoice_revenue
    invoice_items.invoice_item_revenue
  end

  def self.total_invoices_revenue
    join(:invoice_items).sum("unit_price * quantity").limit(5)
  end
end
