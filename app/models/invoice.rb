class Invoice < ApplicationRecord
  enum status: ["Cancelled", "Completed", "In Progress"]

  belongs_to :customer
  
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  
  def self.incomplete_invoices
    where(status: "In Progress").order(:created_at)
  end
end
