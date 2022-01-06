class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  validates :name, presence: true

  def top_five_customers
    Customer.joins(:transactions)
             .where(transactions: {result: "success"})
             .group(:id)
             .select("customers.*, count(transactions) as good_transactions")
             .order(good_transactions: :desc).limit(5)
  end

  def items_ready_to_ship
    Item.joins(:invoice_items)
            .where(invoice_items: {status: 1})
            .includes(:invoices)
            .order(created_at: :asc)
  end
end
