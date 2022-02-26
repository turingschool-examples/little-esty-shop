class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }


  def total_revenue
    self.items.sum(:unit_price)
  end

  def self.incomplete
    not_cancelled = self.where.not(status: 1).pluck(:id)
    InvoiceItem.where.not(status: "shipped").where(invoice_id: not_cancelled)
  end
end
