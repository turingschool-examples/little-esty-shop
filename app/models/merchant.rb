class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, -> { distinct }, through: :invoice_items
  has_many :transactions, -> { distinct }, through: :invoices
  has_many :customers, -> { distinct }, through: :invoices

  validates :name, presence: true

  def top_five_customers
    customers.joins(:transactions).where(transactions: {result: 'success'}).select("customers.*, CONCAT(first_name,' ',last_name) as name, count(DISTINCT transactions.id) as transactions_count").group("customers.id").order("transactions_count desc").limit(5)
  end

  def items_not_shipped
    invoice_items.select('invoice_items.*').where(status: [0, 1]).joins(:invoice).order('invoices.created_at')
  end

  def enabled_items
    items.where(is_enabled: true)
  end

  def disabled_items
    items.where(is_enabled: false)
  end
end
