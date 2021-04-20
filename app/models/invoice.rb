class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [ 'in progress', 'cancelled', 'completed' ]

  scope :incomplete_invoices, -> { includes(:invoice_items).where.not(status: "completed").distinct.order(:created_at)}

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def self.distinct_invoices
    distinct
  end

  def self.ordered_by_date
    joins(:invoice_items, :items)
    .order(:created_at)
    .group(:id)
    .select("created_at")
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end
end
