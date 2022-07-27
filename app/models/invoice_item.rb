class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_numericality_of :quantity
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
  validates_presence_of :status
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item 
  has_many :customers, through: :merchants 
  has_many :transactions, through: :invoice 

  enum status: { 'pending' => 0, 'packaged' => 1, 'shipped' => 2}
end
