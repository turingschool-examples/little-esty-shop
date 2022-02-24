class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  enum status: {enabled: 0, disabled: 1}
  
  validates :name, presence: true
                        
    def favorite_customers(count)
      Merchant.joins(invoice_items: [invoice: [customer: :transactions]])
      .where(merchants: {id: id}, transactions: {result: 0})
      .select("customers.*").group("customers.id").order(count: :desc)
      .limit(count)
    end

    def items_ready_to_ship
      Merchant.joins(invoice_items: [invoice: :transactions])
      .where(merchants: {id: id}, invoice_items: {status: [0,1]}, invoices: {status: [0,1]}, transactions: {result: 0})
      .select("items.name, invoices.id, invoices.created_at").order("invoices.created_at ASC")                            
    end

    def self.top_merchants(count)
      joins(items: [invoice_items: [invoice: :transactions]])
      .where(transactions: {result: 0})
      .group(:id)
      .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .order(revenue: :desc)
      .limit(count)
    end
  end
