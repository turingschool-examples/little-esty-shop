class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items

  enum status: [:enabled, :disabled]

  def favorite_customers
    transactions
    .joins(invoice: :customer)
    .where('result = ?', 1)
    .select("customers.*, count('transactions.result') as top_result")
    .group("customers.id")
    .order(top_result: :desc)
    .limit(5)
  end

  def ordered_items_to_ship
    item_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:item_id)
    Item.order(:created_at).find(item_ids)
  end


end
