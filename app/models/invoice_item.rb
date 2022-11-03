class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:pending, :packaged, :shipped]
  
  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true


  def self.incomplete_invoices
    InvoiceItem.where.not(status:2).distinct.order(:created_at)
  end
end
