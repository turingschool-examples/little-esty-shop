class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { "cancelled" => 0,
                 "completed" => 1,
                 "in progress" => 2
               }

  def self.incomplete_invoices
    joins(:invoice_items)
    .where(invoice_items: {status: ['0','1']})
    .group(:id)
    .order(:created_at )
  end

  def invoice_revenue
    invoice_items.invoice_item_revenue
  end

  def self.highest_date
    select("invoices.created_at")
      .order(created_at: :desc)
      .group(:created_at)
      .order("invoices.count DESC")
      .first
      .created_at
  end
end
