class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:pending, :packaged, :shipped]

<<<<<<< HEAD
  def self.incomplete_invoices
    InvoiceItem.where.not(status:2).pluck(:invoice_id)
  end
=======
  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true
>>>>>>> 31c77b12d8f68ec06b9680a4bbd4c108732e5220
end
