class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name, :status

  def items_ready_to_ship
    merchant_items = Item.where("merchant_id = #{self.id}")
    InvoiceItem.where(item_id: merchant_items).where(status: [0,1]).order(:created_at)
  end

  def top_5_customers
    customer_ids = customers.joins(:transactions).distinct
                            .where(transactions: { result: "success" })
                            .group(:id).count(:transactions)
                            .sort_by { |id, count| [count, -id] }.reverse
                            .first(5)
                            .map { |customer_count| customer_count[0] }
    Customer.find(customer_ids)
  end

  def self.top_5_merchants_by_revenue
    joins(invoices: :transactions)
          .where(transactions: {result: 'success'})
          .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
          .group(:id)
          .order(total_revenue: :desc)
          .limit(5)
  end
  
  def best_day
    best_day_revenue = invoices.group("DATE(invoices.created_at)").sum("invoice_items.quantity * invoice_items.unit_price").sort_by { |day, revenue| revenue }.last
    best_day_revenue[0]
  end

  def top_5_items
    top_5_items = self.items.joins(invoice_items: [:invoice]).where(invoices: {status: 2}).select("items.*, sum(invoice_items.quantity * invoice_items.unit_price)").group(:id).order(sum: :desc).limit(5).to_a
  end

end
