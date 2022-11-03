class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_one :merchant, through: :items

  validates_presence_of :status, :customer_id

  enum status: { 'in progress' => 0, completed: 1, canceled: 2 }

  def self.incomplete_invoices
    joins(:invoice_items)
    .where('invoice_items.status=0 OR invoice_items.status=1')
  end
end
