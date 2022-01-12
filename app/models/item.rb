class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  enum status: [:Disabled, :Enabled]

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: {only_integer: true}


  def self.invoice_finder(merchant_id)
    Invoice.joins(:invoice_items => :item).where(:items => {:merchant_id => merchant_id}).distinct 
  end

  def self.enabled_items
    Item.all.where(status: 1)
  end

  def self.disabled_items
    Item.all.where(status: 0)
  end

  def revenue
    invoice_items.revenue
  end

  def best_day
    invoices.joins(:transactions, :invoice_items).where(transactions: {result: 0})
    .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order(:revenue)
    .first.created_at
  end
end
