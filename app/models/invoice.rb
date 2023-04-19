class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, -> { distinct }, through: :invoice_items
  has_many :merchants, -> { distinct }, through: :items

  validates :status, presence: true

  enum status: ["In Progress", "Completed", "Cancelled"]

  def self.find_and_sort_incomplete_invoices
    joins(:invoice_items).where('invoice_items.status != ?', '2').group(:id).order(:created_at)
  end

  def self.find_with_successful_transactions
    joins(:transactions).where('transactions.result = true').distinct
  end

  def self.order_by_id
    order(:id)
  end

  def customer_name
    customer.first_name + " " + customer.last_name
  end

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end
end
