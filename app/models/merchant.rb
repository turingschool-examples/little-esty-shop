class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name
  enum status: {enabled: 0, disabled: 1}

  def top_customers
    temp = Transaction.joins(invoice: :customer)
    .where("result =?", 0)
    .where("status =?", 1)
    .select("customers.*, count(transactions.id) as top_count")
    .group("customers.id")
    .order(top_count: :desc).limit(5)
    temp
  end

  def not_shipped
    item_ids = invoice_items.where.not(status: "2")
                            .order(:created_at)
                            .pluck(:item_id)
    item_ids.map do |item_id|
      Item.find(item_id)
    end.uniq
  end

  def top_five_items_by_revenue
    items.joins(invoices: :transactions)
    .where('transactions.result = 0')
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price)as total_revenue")
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end
  
  def self.enabled_merchants
    where(status: 0)    
  end

  def self.disabled_merchants
    where(status: 1)    
  end
end
