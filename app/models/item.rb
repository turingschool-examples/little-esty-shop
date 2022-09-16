class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def self.successful_transactions
    joins(invoices: :transactions)
    .where(transactions: { result: 0 })
  end

  def self.find_items_to_ship(merchant_id)
    Item.select(:id, :name, "invoices.created_at as invoice_create_date", "invoice_items.invoice_id as invoice_id")
      .joins(:invoices, :invoice_items)
      .distinct
      .where.not("invoice_items.status = ?", 2)
      .where(merchant_id: merchant_id)
      .order("invoice_create_date")
  end
  
  def current_price
    unit_price.to_f / 100
  end

  def best_day
    invoices
    .joins(:transactions)
    .select('invoices.*, count(invoices) as invoice_count')
    .group('invoices.id')
    .where(transactions: {result: 0})
    .order('invoice_count desc')
    .first
    .created_at
  end

end