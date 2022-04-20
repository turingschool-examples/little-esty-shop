class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  belongs_to :merchant

  enum status: { "disabled" => 0, "enabled" => 1}

  def to_dollars
    unit_price.to_f / 100
  end

  def top_date_sales
 invoices.select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as total_rev")
      .group("invoices.created_at")
      .order("total_rev")
      .first
      .created_at  
  end
end
