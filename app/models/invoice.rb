class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
  validates_presence_of :status, :customer_id

  enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }


  def all_revenue
    invoice_items.sum('unit_price * quantity')
  end
  
  def total_revenue(merchant)
    invoice_items
      .joins(item: :merchant)
      .where("items.merchant_id = #{merchant.id}")  
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.incomplete_invoices
    joins(:invoice_items)
      .where('invoice_items.status=0 OR invoice_items.status=1')
      .order(:created_at)
  end

  def decimal_discount
    percentage.to_f / 100
  end

  def revenue_with_discount(merchant)
    items = invoice_items
      .joins(item: {merchant: :bulk_discounts})
      .where("invoice_items.quantity >= bulk_discounts.quantity_threshold AND items.merchant_id = #{merchant.id}")
    
    if items.empty?
      return all_revenue
    else
      discounts = merchant.bulk_discounts.order(quantity_threshold: :desc)
      items.each do |item|
        discounts.each do |discount|
          if item.quantity >= discount.quantity_threshold
            discount_revenue = (item.quantity * item.unit_price) - (item.quantity * item.unit_price * (discount.percentage / 100))
            return discount_revenue
          end
        end
      end
    end
  end
end
