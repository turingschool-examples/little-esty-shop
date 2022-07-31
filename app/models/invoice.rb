class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items 

  enum status: { 'in progress' => 0, 'cancelled' => 1, 'completed' => 2 }

  def total_rev 
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
