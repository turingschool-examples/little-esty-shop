class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  validates :name, presence: true

  def top_five_customers
    customers.joins(:transactions)
             .where(transactions: {result: "success"})
             .group(:id)
             .select("customers.*, count(transactions) as good_transactions")
             .order(good_transactions: :desc)
             .limit(5)
  end

  def items_ready_to_ship
    Item.joins(:invoice_items)
            .where(invoice_items: {status: 1})
            .includes(:invoices)
            .order(created_at: :asc)
  end

  def top_five_items
    items.joins(invoice_items: :transactions)
         .where(transactions: {result: "success"})
         .group(:id)
         .select("items.*, sum(quantity * invoice_items.unit_price) as revenue")
         .order(revenue: :desc)
         .limit(5)
  end

  def self.top_five_merchants
          joins(invoice_items: :transactions)
         .where(transactions: {result: "success"})
         .group(:id)
         .select("merchants.*, sum(quantity * invoice_items.unit_price) as revenue")
         .order(revenue: :desc)
         .limit(5)
  end

  def top_merchant_best_day #NEED TO CHECK AND SEE THAT THIS IS CORRECTLY TESTING THE BEST DAYS
    invoices.joins(:transactions)
          .select("invoices.*, sum(quantity) as total_sales")
          .group(:id)
          .order(total_sales: :desc)
          .first.updated_at
  end
end
