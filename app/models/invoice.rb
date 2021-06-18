class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: {'in progress': 0, cancelled: 1, completed: 2}

  def self.incomplete_invoices
    joins(:invoice_items)
      .where('invoice_items.status != 2')
      .where(status: 0)
      .order(:created_at)
      .distinct
  end
end
