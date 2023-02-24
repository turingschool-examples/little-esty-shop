class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    customers.joins(:transactions).where(transactions: {result: 'success'})
    .select("customers.*, count(DISTINCT transactions.id) as transaction_count")
    .group("customers.id").order("transaction_count desc").limit(5)
  end

    # def self.top_5_by_revenue
  #   Merchant.joins(:items, :invoice_items, :invoices, :transactions)
  #   .where("transactions.result = 'success'")
  #   .group("merchants.id")
  #   .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
  #   .order("revenue desc")
  #   .limit(5)
  # end

  def self.top_5_by_revenue
    Merchant.find_by_sql("
      SELECT merchants.*,
      SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue
      FROM merchants
      INNER JOIN items ON items.merchant_id = merchants.id
      INNER JOIN invoice_items ON invoice_items.item_id = items.id
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE transactions.result = 'success'
      GROUP BY merchants.id
      ORDER BY revenue desc
      LIMIT 5;
      ")
    end
end
