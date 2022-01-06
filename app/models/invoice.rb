class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :transactions

  enum status: {completed: 0, "in progress" = 1, cancelled: 2}

  def incomplete_invoices
    # Catalog.where.not("state = ?", "finished")
  end
end
