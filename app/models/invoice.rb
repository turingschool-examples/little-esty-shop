class Invoice < ApplicationRecord
  validates :status, presence: true
  enum status: [ 'in progress', 'cancelled', 'completed' ]

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.all_incomplete_invoices
    self.where.not(status: "completed").order(:created_at)
  end
  # InvoiceItem.select(:invoice_id).where.not(status: :shipped)
  # InvoiceItem.select(:invoice_id).distinct.where.not(status: :shipped).pluck(:invoice_id)
end
