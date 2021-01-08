class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id

  enum status: ['cancelled', 'completed', 'in progress']
  
  belongs_to :customer
  belongs_to :merchant
  
  has_many :transactions, dependent: :destroy
  has_many :invoice_items 
  has_many :items, through: :invoice_items

  def self.not_shipped
    InvoiceItem.joins(:invoice).where.not(status: 2).select('invoice_id').distinct.order(:invoice_id)
  end
end
