class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  validates :name, presence: true

  def top_customers
    Customer.joins(invoices: :transactions)
      .select("customers.*, count(transactions.id) as transaction_id_count")
      .limit(5)
      .group(:id)
      .order(transaction_id_count: :desc)
      .where(transactions: { result: 1 } )
  end

  def ready_items
    Item.joins(:invoice_items)
      .group(:id)
      .where(invoice_items: {status: "packaged"})
      .select(:name, :id)
      .limit(5)
  end

  def filter_item_status(status_enum)
    items.where(status: status_enum)
  end
end
