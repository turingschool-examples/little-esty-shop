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

  def self.most_expensive
    order(unit_price: :desc).limit(5)
  end
end
