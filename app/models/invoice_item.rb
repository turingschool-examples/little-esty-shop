class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  enum status: [ :packaged, :pending, :shipped ]

  belongs_to :item
  belongs_to :invoice

  def self.find_all_invoices_not_shipped
    self.select(:id).where.not(status: 'shipped').distinct.pluck(:invoice_id)
  end
end
