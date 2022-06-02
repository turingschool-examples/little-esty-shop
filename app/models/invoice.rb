class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status
  
  def total_revenue
    invoice_items.sum('unit_price * quantity') * 0.01.to_f
  end

end
