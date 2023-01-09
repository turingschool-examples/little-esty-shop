class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: ["cancelled", "in progress", "completed" ]

  def self.incomplete
    joins(:invoice_items).where("invoice_items.status != 2").distinct.order(:created_at)
  end

  def created
    created_at.strftime("%A, %B %-d, %Y")
  end

  def self.total_revenue(id)
    # binding.pry
    joins(:transactions, :invoice_items)
    .where("invoices.id = #{id} AND transactions.result = 1")
    .group(:id)
    .select('sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    
    # .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end