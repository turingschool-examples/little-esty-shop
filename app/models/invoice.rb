class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  validates :customer, presence: true


  enum status: {
    "in progress" => 0,
    "completed" => 1,
    "cancelled" => 2
  }

  def pretty_created_at
    created_at.strftime("%A, %B %-d, %Y")
  end

  def customer_name
    customer.first_name + " " + customer.last_name
  end

  def items_info
    invoice_items.joins(:item)
      .select("invoice_items.*, items.name")
  end

  def total_revenue
    item_total = invoice_items.find_by_sql("select quantity * unit_price as item_total from invoice_items")
    item_total.pluck(:item_total).sum
  end

  def self.incomplete
    joins(:invoice_items).where.not(invoice_items: { status: 2 }).order(:created_at).uniq
  end
end
