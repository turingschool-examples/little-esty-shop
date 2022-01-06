class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :transactions

  enum status: [:cancelled, 'in progress', :completed]

  def incomplete_invoices
    # Catalog.where.not("state = ?", "finished")
  end
end
