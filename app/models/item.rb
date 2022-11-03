class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, :description, :status, :presence => true
  validates :unit_price, presence: :true, numericality: :true

  enum status: [:enabled, :disabled]

  def current_price
    unit_price / 100.0
  end

  def top_date
    invoices.joins(:invoice_items)
      .select('invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
      .group('invoices.created_at')
      .order('revenue DESC')
      .first.created_at.strftime('%m/%d/%Y')
  end

  def self.top_5_items
    select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .from('transactions')
      .joins("INNER JOIN invoices on invoices.id = transactions.invoice_id")
      .joins("INNER JOIN invoice_items on invoice_items.invoice_id = invoices.id")
      .joins("INNER JOIN items on items.id = invoice_items.item_id")
      .where('result = ?', 'success')
      .group('items.id')
      .order('revenue DESC')
      .limit(5)
  end
end
