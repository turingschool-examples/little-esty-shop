class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.favorite_customers
    joins(:transactions)
    .where('result = ?', 1)
    .select("customers.*, count('transactions.result') as top_result")
    .order(top_result: :desc)
    .limit(5)
  end

  def number_of_transactions(customer)
    customer.transactions.where('result = ?', 1).count
  end

  def ordered_items_to_ship
    item_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:item_id)
    Item.order(:created_at).find(item_ids)
  end

end
