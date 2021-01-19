class Merchant < ApplicationRecord
  validates_presence_of :name

  enum status: ['Enabled', 'Disabled']

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items
  has_many :discounts

  def top_five_customers
    self.transactions.joins(invoice: :customer)
      .where('transactions.result = ?', "success")
      .select('customers.first_name, count(transactions) as successful_transactions')
      .group('customers.id')
      .order('successful_transactions desc')
      .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items).where.not('invoice_items.status = ?', 2)
  end

  def order_merchant_items_by_invoice_created_date(items)
    items.joins(:invoices).where('invoices.merchant_id = ?', self.id).order('invoices.created_at ASC')
  end

  def self.enabled_merchants
    where('status = ?', 0).order(:name)
  end

  def self.disabled_merchants
    where('status = ?', 1).order(:name)
  end

  def self.top_five_merchants
    self.joins([invoices: :transactions], :invoice_items)
    .where('transactions.result = ?', "success")
    .select("merchants.id, merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group('merchants.id')
    .order('total_revenue desc')
    .limit(5)
  end

  def enabled_items
    items.where(status: 'Enabled')
  end

  def disabled_items
    items.where(status: 'Disabled')
  end

  def total_discount_revenue(invoice_item_arg)
    final_percentage = 0
    invoice_item_arg.each do |invoice_item|
      discount = (discounts.where('quantity_threshold <= ?', invoice_item.quantity)).pluck(:discount_percentage).first
      discount_percentage = 100 - discount
      final_percentage = invoice_item.item.total_price(invoice_item.item.id, invoice_item.invoice_id) * (discount_percentage / 100)
    end
    final_percentage
  end
  # discounts.joins(items: :invoice_items).where('discounts.merchant_id = items.merchant_id').where('discounts.quantity_threshold <= invoice_items.quantity').order(discount_percentage: :desc).pluck(:discount_percentage).first
# discounts.joins(items: :invoice_items).select('discounts.discount_percentage, discounts.quantity_threshold, invoice_items.quantity')
  # def find_invoice_item(invoice_arg)
  #   require "pry"; binding.pry
  #   # self.joins(:invoice_items).where(invoice_id: self.id)
  # end

end
