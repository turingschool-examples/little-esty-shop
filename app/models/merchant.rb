class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  enum status: [ :disabled, :enabled ]
  validates :name, presence: true, length: { maximum: 50 }

  def top_5_customers
    Customer.joins("INNER join invoices ON invoices.customer_id = customers.id")
            .joins("INNER join transactions ON transactions.invoice_id = invoices.id")
            .joins("INNER join invoice_items ON invoice_items.invoice_id = invoices.id")
            .joins("INNER join items ON invoice_items.item_id = items.id")
            .joins("INNER join merchants ON items.merchant_id = merchants.id")
            .where("transactions.result = 1 and merchants.id = #{self.id}")
            .group(:first_name)
            .order('count_id desc')
            .limit(5)
            .count('id')

    #add last name in group and iterate through key in
    # .joins(invoices: [:transactions, {items: :merchant}])
    #in test eq([array of them]) should work
  end

  def items_ready_to_ship
    invoice_items.where("invoice_items.status = 1").order('created_at asc')
  end

  def top_5_items
    # require "pry"; binding.pry

    Item.joins([:merchant, {invoices: :transactions}])
        .where(merchants: {id: self.id}, transactions: {result: 1}, invoices: {status: 2})
        .select('items.*, sum(quantity * invoice_items.unit_price) as revenue')
        .group('items.id')
        .order('revenue DESC')
        .limit(5)
  end

  def self.top_5_by_revenue
    joins(:transactions)
    .where("result = ? AND invoices.status = ?", 1, 2)
    .select('merchants.*, sum(quantity * invoice_items.unit_price) as revenue')
    .group('merchants.id')
    .order('revenue DESC')
    .limit(5)
  end

  def top_selling_date
    invoices
    .where("invoices.status = ?", 2)
    .select('invoices.*, sum(quantity * invoice_items.unit_price) as sum_id')
    .group(:id)
    .order('sum_id desc')
    .first
    .updated_at
  end

  def total_revenue
    invoice_items.joins(invoice: :transactions)
                 .where("result = ? AND invoices.status = ?", 1, 2)
                 .sum('quantity * invoice_items.unit_price')
  end
end
