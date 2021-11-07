class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name 

  def top_customers
    Transaction.joins(invoice: :customer)
    .where("result =?", 0)
    .where("status =?", 1)
    .select("customers.*, count(transactions.id) as top_count")
    .group("customers.id")
    .order(top_count: :desc)
    .limit(5)
  end

  def not_shipped
    item_ids = invoice_items.where.not(status: "2").order(:created_at).pluck(:item_id)
    item_ids.map do |item_id|
      Item.find(item_id)
    end
  end
end