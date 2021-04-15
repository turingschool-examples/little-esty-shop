class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status, :customer_id

  enum status: [:"in progress", :completed, :cancelled]

  scope :incomplete_invoices, -> { includes(:invoice_items).where.not(status: 2).distinct.order(:created_at)}
end
