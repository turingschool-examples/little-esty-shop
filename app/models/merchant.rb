class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  validates_presence_of :name

  def top_five_customers
    Customer.select("customers.*, count(distinct transactions) as transaction_count")
            .left_joins(:transactions, :items).group(:id)
            .where('transactions.result = ?', 'success')
            .where('items.merchant_id = ?', self.id)
            .order("transaction_count desc").limit(5)
  end

  def ready_to_ship_items
    items.select("items.*, invoice_id, status").joins(:invoice_items).where("invoice_items.status = ?", "1")
  end

  def self.group_by_enabled
    Merchant.where(enabled: true) 
  end

  def self.group_by_not_enabled
    Merchant.where(enabled: false)
  end
end