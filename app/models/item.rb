class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  enum status: ['Enabled', 'Disabled']

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def quantity_ordered(itm_id, invc_id)
    invoice_items.where(item_id: itm_id, invoice_id: invc_id).pluck(:quantity)
  end

  def total_price(itm_id, invc_id)
    invoice_items.where(item_id: itm_id, invoice_id: invc_id).sum('unit_price * quantity')
  end

  def status(itm_id, invc_id)
    invoice_items.where(item_id: itm_id, invoice_id: invc_id).pluck(:status)
  end

  def self.top_5_popular_items
  
    Item.joins(:transactions)
    .where("transactions.result = 'success'")
    .select('items.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS highest_in_revenue')
    .group(:id)
    .order('highest_in_revenue desc')
    .limit(5)
  end 

  # def best_sales_day(itm_id, invc_id)
  #   invoice_items.where(item_id: itm_id, invoice_id: invc_id).order(invoice.created_at).sum('unit_price * quantity').pluck(:created_at).limit(1)
  # end
end
