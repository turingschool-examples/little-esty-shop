class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: ["disabled", "enabled" ]

  def self.disabled_status_items(params)
    where(merchant_id: params[:merchant_id]).where(status: "disabled")
  end 

  def self.enabled_status_items(params)
    where(merchant_id: params[:merchant_id]).where(status: "enabled")
  end

  def self.five_popular_items(merchant_id)

    select('items.*, SUM(invoice_items.unit_price* invoice_items.quantity) as revenue_generated')
      .joins(:merchant)
      .where(merchants: {id: merchant_id})
      .joins(:transactions)
      .where(transactions: {result: "success"})
      .joins(:invoice_items)
      .group(:id)
      .order('revenue_generated DESC')
      .limit(5)
  end
end
