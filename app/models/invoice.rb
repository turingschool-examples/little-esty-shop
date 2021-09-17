class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where(invoice_items: {status: [0,1]})
  end

  enum status: {
    "in progress": 0,
    "cancelled": 1,
    "completed": 2
  }

  def date
    created_at.strftime("%A, %B %d, %Y")
  end
end
