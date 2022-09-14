class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :status, presence: true
  enum status: [ :in_progress, :completed, :cancelled]

  def self.not_shipped_invoices
    joins(:invoice_items, :customer).where('invoice_items.status != 2').order(:created_at)
  end
end
